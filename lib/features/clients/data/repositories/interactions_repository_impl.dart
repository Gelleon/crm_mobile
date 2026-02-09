import 'package:injectable/injectable.dart';
import '../../domain/entities/interaction.dart';
import '../../domain/repositories/interactions_repository.dart';
import '../datasources/interactions_local_datasource.dart';

@LazySingleton(as: InteractionsRepository)
class InteractionsRepositoryImpl implements InteractionsRepository {
  final InteractionsLocalDataSource _dataSource;

  InteractionsRepositoryImpl(this._dataSource);

  @override
  Future<List<Interaction>> getInteractions(String clientId) =>
      _dataSource.getInteractions(clientId);

  @override
  Future<void> addInteraction(Interaction interaction) =>
      _dataSource.addInteraction(interaction);

  @override
  Future<void> deleteInteraction(String id) =>
      _dataSource.deleteInteraction(id);
}
