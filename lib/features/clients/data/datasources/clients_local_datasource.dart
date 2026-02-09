import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/entities/client.dart';

abstract class ClientsLocalDataSource {
  Future<List<Client>> getClients();
  Future<Client?> getClient(String id);
  Future<void> createClient(Client client);
  Future<void> updateClient(Client client);
  Future<void> deleteClient(String id);
  Future<List<Client>> searchClients(String query);
}

@LazySingleton(as: ClientsLocalDataSource)
class ClientsLocalDataSourceImpl implements ClientsLocalDataSource {
  final Database _db;

  ClientsLocalDataSourceImpl(this._db);

  @override
  Future<List<Client>> getClients() async {
    final result = await _db.query('clients', orderBy: 'created_at DESC');
    return result.map((e) => Client.fromJson(e)).toList();
  }

  @override
  Future<Client?> getClient(String id) async {
    final result = await _db.query('clients', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) return null;
    return Client.fromJson(result.first);
  }

  @override
  Future<void> createClient(Client client) async {
    await _db.insert(
      'clients',
      client.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateClient(Client client) async {
    await _db.update(
      'clients',
      client.toJson(),
      where: 'id = ?',
      whereArgs: [client.id],
    );
  }

  @override
  Future<void> deleteClient(String id) async {
    await _db.delete('clients', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Client>> searchClients(String query) async {
    final result = await _db.query(
      'clients',
      where: 'name LIKE ? OR phone LIKE ? OR email LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      orderBy: 'created_at DESC',
    );
    return result.map((e) => Client.fromJson(e)).toList();
  }
}
