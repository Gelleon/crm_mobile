import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/client.dart';
import '../../domain/repositories/clients_repository.dart';
import '../../../../core/di/injection.dart';

part 'clients_provider.g.dart';

@riverpod
class Clients extends _$Clients {
  @override
  Future<List<Client>> build() async {
    final repository = getIt<ClientsRepository>();
    return repository.getClients();
  }

  Future<void> addClient(Client client) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = getIt<ClientsRepository>();
      await repository.createClient(client);
      return repository.getClients();
    });
  }

  Future<void> updateClient(Client client) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = getIt<ClientsRepository>();
      await repository.updateClient(client);
      return repository.getClients();
    });
  }

  Future<void> deleteClient(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = getIt<ClientsRepository>();
      await repository.deleteClient(id);
      return repository.getClients();
    });
  }

  Future<void> searchClients(String query) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = getIt<ClientsRepository>();
      if (query.isEmpty) {
        return repository.getClients();
      }
      return repository.searchClients(query);
    });
  }
}

@riverpod
Client? client(ClientRef ref, String id) {
  final clients = ref.watch(clientsProvider).valueOrNull;
  if (clients == null) return null;
  try {
    return clients.firstWhere((c) => c.id == id);
  } catch (_) {
    return null;
  }
}
