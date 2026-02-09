import '../entities/client.dart';

abstract class ClientsRepository {
  Future<List<Client>> getClients();
  Future<Client?> getClient(String id);
  Future<void> createClient(Client client);
  Future<void> updateClient(Client client);
  Future<void> deleteClient(String id);
  Future<List<Client>> searchClients(String query);
}
