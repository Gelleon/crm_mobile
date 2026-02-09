import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../deals/domain/entities/deal.dart';
import '../../../deals/domain/repositories/deals_repository.dart';

part 'analytics_provider.freezed.dart';
part 'analytics_provider.g.dart';

enum AnalyticsPeriod {
  today,
  week,
  month,
  custom;

  String get label {
    switch (this) {
      case AnalyticsPeriod.today:
        return 'Сегодня';
      case AnalyticsPeriod.week:
        return 'Неделя';
      case AnalyticsPeriod.month:
        return 'Месяц';
      case AnalyticsPeriod.custom:
        return 'Период';
    }
  }
}

@freezed
class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState({
    required AnalyticsPeriod period,
    required DateTime startDate,
    required DateTime endDate,
    required double totalTurnover,
    required int successfulDealsCount,
    required double averageCheck,
    required double minDeal,
    required double maxDeal,
    required List<Deal> deals,
    required bool isLoading,
    required double targetTurnover,
    required double totalProfit,
    required double averageMargin,
  }) = _AnalyticsState;

  factory AnalyticsState.initial() => AnalyticsState(
    period: AnalyticsPeriod.month,
    startDate: DateTime.now().subtract(const Duration(days: 30)),
    endDate: DateTime.now(),
    totalTurnover: 0,
    successfulDealsCount: 0,
    averageCheck: 0,
    minDeal: 0,
    maxDeal: 0,
    deals: [],
    isLoading: false,
    targetTurnover: 0,
    totalProfit: 0,
    averageMargin: 0,
  );
}

@riverpod
class Analytics extends _$Analytics {
  @override
  AnalyticsState build() {
    // Initial load
    Future.microtask(() async {
      await setPeriod(AnalyticsPeriod.month);
      await _loadTarget();
    });
    return AnalyticsState.initial();
  }

  Future<void> _loadTarget() async {
    final storage = getIt<SecureStorageService>();
    final target = await storage.getTargetTurnover();
    if (target != null) {
      state = state.copyWith(targetTurnover: target);
    }
  }

  Future<void> updateTarget(double target) async {
    final storage = getIt<SecureStorageService>();
    await storage.saveTargetTurnover(target);
    state = state.copyWith(targetTurnover: target);
  }

  Future<void> setPeriod(
    AnalyticsPeriod period, {
    DateTime? start,
    DateTime? end,
  }) async {
    DateTime startDate;
    DateTime endDate = DateTime.now();

    switch (period) {
      case AnalyticsPeriod.today:
        startDate = DateTime(endDate.year, endDate.month, endDate.day);
        endDate = startDate
            .add(const Duration(days: 1))
            .subtract(const Duration(seconds: 1));
        break;
      case AnalyticsPeriod.week:
        startDate = endDate.subtract(const Duration(days: 7));
        break;
      case AnalyticsPeriod.month:
        startDate = DateTime(endDate.year, endDate.month, 1);
        break;
      case AnalyticsPeriod.custom:
        if (start == null || end == null) return;
        startDate = start;
        endDate = end;
        break;
    }

    state = state.copyWith(
      period: period,
      startDate: startDate,
      endDate: endDate,
      isLoading: true,
    );

    await _fetchData(startDate, endDate);
  }

  Future<void> _fetchData(DateTime start, DateTime end) async {
    final repository = getIt<DealsRepository>();
    final deals = await repository.getSuccessfulDeals(start, end);
    final turnover = await repository.getTurnover(start, end);

    double min = 0;
    double max = 0;

    if (deals.isNotEmpty) {
      min = deals.map((e) => e.totalAmount).reduce((a, b) => a < b ? a : b);
      max = deals.map((e) => e.totalAmount).reduce((a, b) => a > b ? a : b);
    }

    double totalProfit = 0;
    for (final deal in deals) {
      for (final product in deal.products) {
        totalProfit += product.profit;
      }
    }

    final averageMargin = turnover > 0 ? (totalProfit / turnover) * 100 : 0.0;

    state = state.copyWith(
      deals: deals,
      totalTurnover: turnover,
      successfulDealsCount: deals.length,
      averageCheck: deals.isEmpty ? 0 : turnover / deals.length,
      minDeal: min,
      maxDeal: max,
      isLoading: false,
      totalProfit: totalProfit,
      averageMargin: averageMargin,
    );
  }
}
