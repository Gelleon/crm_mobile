import '../entities/deal.dart';
import '../entities/deal_history.dart';

abstract class DealsRepository {
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
