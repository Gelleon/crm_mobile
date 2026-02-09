import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/entities/deal.dart';
import '../../domain/entities/deal_history.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/deal_status.dart';

abstract class DealsLocalDataSource {
  Future<List<Deal>> getDeals();
  Future<List<Deal>> getDealsByClient(String clientId);
  Future<Deal?> getDeal(String id);
  Future<void> createDeal(Deal deal);
  Future<void> updateDeal(Deal deal);
  Future<void> deleteDeal(String id);
  Future<void> restoreDeal(String id);
  Future<double> getTurnover(DateTime start, DateTime end);
  Future<List<Deal>> getSuccessfulDeals(DateTime start, DateTime end);
  Future<void> saveHistory(DealHistory history);
  Future<List<DealHistory>> getHistory(String dealId);
}

@LazySingleton(as: DealsLocalDataSource)
class DealsLocalDataSourceImpl implements DealsLocalDataSource {
  final Database _db;

  DealsLocalDataSourceImpl(this._db);

  Deal _fromMap(Map<String, dynamic> map) {
    return Deal(
      id: map['id'] as String,
      clientId: map['client_id'] as String,
      products: (jsonDecode(map['products'] as String) as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: DealStatus.values.firstWhere((e) => e.name == map['status']),
      createdAt: DateTime.parse(map['created_at'] as String),
      paymentDate: map['payment_date'] != null
          ? DateTime.parse(map['payment_date'] as String)
          : null,
      totalAmount: map['total_amount'] as double,
      isDeleted: (map['is_deleted'] as int? ?? 0) == 1,
      description: map['description'] as String?,
      authorId: map['author_id'] as String?,
    );
  }

  Map<String, dynamic> _toMap(Deal deal) {
    return {
      'id': deal.id,
      'client_id': deal.clientId,
      'products': jsonEncode(deal.products.map((e) => e.toJson()).toList()),
      'status': deal.status.name,
      'created_at': deal.createdAt.toIso8601String(),
      'payment_date': deal.paymentDate?.toIso8601String(),
      'total_amount': deal.totalAmount,
      'is_deleted': deal.isDeleted ? 1 : 0,
      'description': deal.description,
      'author_id': deal.authorId,
    };
  }

  @override
  Future<List<Deal>> getDeals() async {
    final result = await _db.query(
      'deals',
      where: 'is_deleted = 0',
      orderBy: 'created_at DESC',
    );
    return result.map(_fromMap).toList();
  }

  @override
  Future<List<Deal>> getDealsByClient(String clientId) async {
    final result = await _db.query(
      'deals',
      where: 'client_id = ? AND is_deleted = 0',
      whereArgs: [clientId],
      orderBy: 'created_at DESC',
    );
    return result.map(_fromMap).toList();
  }

  @override
  Future<Deal?> getDeal(String id) async {
    final result = await _db.query('deals', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) return null;
    return _fromMap(result.first);
  }

  @override
  Future<void> createDeal(Deal deal) async {
    await _db.insert(
      'deals',
      _toMap(deal),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateDeal(Deal deal) async {
    await _db.update(
      'deals',
      _toMap(deal),
      where: 'id = ?',
      whereArgs: [deal.id],
    );
  }

  @override
  Future<void> deleteDeal(String id) async {
    await _db.update(
      'deals',
      {'is_deleted': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> restoreDeal(String id) async {
    await _db.update(
      'deals',
      {'is_deleted': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Deal>> getSuccessfulDeals(DateTime start, DateTime end) async {
    final result = await _db.query(
      'deals',
      where:
          '(status = ? OR status = ?) AND payment_date BETWEEN ? AND ? AND is_deleted = 0',
      whereArgs: [
        DealStatus.paid.name,
        DealStatus.completed.name,
        start.toIso8601String(),
        end.toIso8601String(),
      ],
    );
    return result.map(_fromMap).toList();
  }

  @override
  Future<double> getTurnover(DateTime start, DateTime end) async {
    final deals = await getSuccessfulDeals(start, end);
    return deals.fold<double>(0.0, (sum, deal) => sum + deal.totalAmount);
  }

  @override
  Future<void> saveHistory(DealHistory history) async {
    await _db.insert('deal_history', {
      'id': history.id,
      'deal_id': history.dealId,
      'old_status': history.oldStatus.name,
      'new_status': history.newStatus.name,
      'date': history.date.toIso8601String(),
      'comment': history.comment,
    });
  }

  @override
  Future<List<DealHistory>> getHistory(String dealId) async {
    final result = await _db.query(
      'deal_history',
      where: 'deal_id = ?',
      whereArgs: [dealId],
      orderBy: 'date DESC',
    );
    return result.map((map) {
      return DealHistory(
        id: map['id'] as String,
        dealId: map['deal_id'] as String,
        oldStatus: DealStatus.values.firstWhere(
          (e) => e.name == map['old_status'],
        ),
        newStatus: DealStatus.values.firstWhere(
          (e) => e.name == map['new_status'],
        ),
        date: DateTime.parse(map['date'] as String),
        comment: map['comment'] as String?,
      );
    }).toList();
  }
}
