import 'package:injectable/injectable.dart';
import '../../domain/entities/deal.dart';
import '../../domain/entities/deal_history.dart';
import '../../domain/repositories/deals_repository.dart';
import '../datasources/deals_local_datasource.dart';

@LazySingleton(as: DealsRepository)
class DealsRepositoryImpl implements DealsRepository {
  final DealsLocalDataSource _dataSource;

  DealsRepositoryImpl(this._dataSource);

  @override
  Future<List<Deal>> getDeals() => _dataSource.getDeals();

  @override
  Future<List<Deal>> getDealsByClient(String clientId) =>
      _dataSource.getDealsByClient(clientId);

  @override
  Future<Deal?> getDeal(String id) => _dataSource.getDeal(id);

  @override
  Future<void> createDeal(Deal deal) => _dataSource.createDeal(deal);

  @override
  Future<void> updateDeal(Deal deal) => _dataSource.updateDeal(deal);

  @override
  Future<void> deleteDeal(String id) => _dataSource.deleteDeal(id);

  @override
  Future<void> restoreDeal(String id) => _dataSource.restoreDeal(id);

  @override
  Future<double> getTurnover(DateTime start, DateTime end) =>
      _dataSource.getTurnover(start, end);

  @override
  Future<List<Deal>> getSuccessfulDeals(DateTime start, DateTime end) =>
      _dataSource.getSuccessfulDeals(start, end);

  @override
  Future<void> saveHistory(DealHistory history) =>
      _dataSource.saveHistory(history);

  @override
  Future<List<DealHistory>> getHistory(String dealId) =>
      _dataSource.getHistory(dealId);
}
