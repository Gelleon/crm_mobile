import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/interaction.dart';
import '../../domain/repositories/interactions_repository.dart';
import '../../../../core/di/injection.dart';

part 'interactions_provider.g.dart';

@riverpod
class ClientInteractions extends _$ClientInteractions {
  @override
  Future<List<Interaction>> build(String clientId) async {
    final repository = getIt<InteractionsRepository>();
    return repository.getInteractions(clientId);
  }

  Future<void> addInteraction(Interaction interaction) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = getIt<InteractionsRepository>();
      await repository.addInteraction(interaction);
      return repository.getInteractions(clientId);
    });
  }

  Future<void> deleteInteraction(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = getIt<InteractionsRepository>();
      await repository.deleteInteraction(id);
      return repository.getInteractions(clientId);
    });
  }
}
