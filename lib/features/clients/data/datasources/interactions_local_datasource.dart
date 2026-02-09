import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/entities/interaction.dart';

abstract class InteractionsLocalDataSource {
  Future<List<Interaction>> getInteractions(String clientId);
  Future<void> addInteraction(Interaction interaction);
  Future<void> deleteInteraction(String id);
}

@LazySingleton(as: InteractionsLocalDataSource)
class InteractionsLocalDataSourceImpl implements InteractionsLocalDataSource {
  final Database _db;

  InteractionsLocalDataSourceImpl(this._db);

  @override
  Future<List<Interaction>> getInteractions(String clientId) async {
    final result = await _db.query(
      'interactions',
      where: 'client_id = ?',
      whereArgs: [clientId],
      orderBy: 'date DESC',
    );
    return result.map((e) => Interaction.fromJson(e)).toList();
  }

  @override
  Future<void> addInteraction(Interaction interaction) async {
    await _db.insert(
      'interactions',
      interaction.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteInteraction(String id) async {
    await _db.delete(
      'interactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
