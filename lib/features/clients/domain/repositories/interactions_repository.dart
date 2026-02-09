import '../../domain/entities/interaction.dart';

abstract class InteractionsRepository {
  Future<List<Interaction>> getInteractions(String clientId);
  Future<void> addInteraction(Interaction interaction);
  Future<void> deleteInteraction(String id);
}
