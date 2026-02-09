import 'package:injectable/injectable.dart';
import '../../domain/entities/client.dart';
import '../../domain/repositories/clients_repository.dart';
import '../datasources/clients_local_datasource.dart';

@LazySingleton(as: ClientsRepository)
class ClientsRepositoryImpl implements ClientsRepository {
  final ClientsLocalDataSource _dataSource;

  ClientsRepositoryImpl(this._dataSource);

  @override
  Future<List<Client>> getClients() => _dataSource.getClients();

  @override
  Future<Client?> getClient(String id) => _dataSource.getClient(id);

  @override
  Future<void> createClient(Client client) => _dataSource.createClient(client);

  @override
  Future<void> updateClient(Client client) => _dataSource.updateClient(client);

  @override
  Future<void> deleteClient(String id) => _dataSource.deleteClient(id);

  @override
  Future<List<Client>> searchClients(String query) =>
      _dataSource.searchClients(query);
}
