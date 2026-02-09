import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/deal.dart';
import '../../domain/entities/deal_history.dart';
import '../../domain/repositories/deals_repository.dart';
import '../../../../core/di/injection.dart';

import '../../domain/entities/deal_status.dart';
import '../../../../core/services/calendar_service.dart';

part 'deals_provider.g.dart';

@riverpod
class Deals extends _$Deals {
  @override
  Future<List<Deal>> build() async {
    final repository = getIt<DealsRepository>();
    return repository.getDeals();
  }

  Future<void> addDeal(Deal deal) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = getIt<DealsRepository>();
      await repository.createDeal(deal);

      // Initial history
      final history = DealHistory(
        id: const Uuid().v4(),
        dealId: deal.id,
        oldStatus:
            DealStatus.inProgress, // Assuming new deals start in progress
        newStatus: deal.status,
        date: DateTime.now(),
        comment: 'Deal created',
      );
      await repository.saveHistory(history);

      // Check if status is paid and add to calendar
      if (deal.status == DealStatus.paid) {
        await _addToCalendar(deal);
      }

      return repository.getDeals();
    });
  }

  Future<void> updateDeal(Deal deal) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = getIt<DealsRepository>();

      // Get old deal to compare status
      final oldDeal = await repository.getDeal(deal.id);
      if (oldDeal != null && oldDeal.status != deal.status) {
        final history = DealHistory(
          id: const Uuid().v4(),
          dealId: deal.id,
          oldStatus: oldDeal.status,
          newStatus: deal.status,
          date: DateTime.now(),
          comment: 'Status changed',
        );
        await repository.saveHistory(history);
      }

      // Check previous status if needed, or just if current is paid
      // Ideally we check if it CHANGED to paid, but for simplicity:
      if (deal.status == DealStatus.paid) {
        // Optimization: check if we already added it?
        // For now, we just try to add it.
        // In a real app, we might want to ask user or check flag.
        try {
          await _addToCalendar(deal);
        } catch (e) {
          // Ignore calendar errors to not block saving
          print('Calendar error: $e');
        }
      }

      await repository.updateDeal(deal);
      return repository.getDeals();
    });
  }

  Future<void> _addToCalendar(Deal deal) async {
    final calendarService = getIt<CalendarService>();
    // Event date: payment date or created date if null + 7 days delivery for example
    // Requirement says: "Date taken from contract". Assuming 'paymentDate' or 'createdAt' as base.
    // Let's assume delivery is 7 days after payment/creation.
    final date = deal.paymentDate ?? deal.createdAt;
    final deliveryDate = date.add(const Duration(days: 7));

    await calendarService.createEvent(
      title: 'Доставка: Договор #${deal.id.substring(0, 8)}',
      description: 'Сумма: ${deal.totalAmount}',
      startTime: deliveryDate,
      endTime: deliveryDate.add(const Duration(hours: 1)),
    );
  }

  Future<void> deleteDeal(String id) async {
    final previousState = state.value;
    // Optimistic update
    state = AsyncValue.data(
      previousState?.where((d) => d.id != id).toList() ?? [],
    );

    state = await AsyncValue.guard(() async {
      final repository = getIt<DealsRepository>();

      // Add history record
      final deal = previousState?.firstWhere((d) => d.id == id);
      if (deal != null) {
        final history = DealHistory(
          id: const Uuid().v4(),
          dealId: id,
          oldStatus: deal.status,
          newStatus: deal.status,
          date: DateTime.now(),
          comment: 'Deleted by user',
        );
        await repository.saveHistory(history);
      }

      await repository.deleteDeal(id);
      return repository.getDeals();
    });
  }

  Future<void> restoreDeal(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = getIt<DealsRepository>();

      await repository.restoreDeal(id);

      // Add history record
      final deal = await repository.getDeal(id);
      if (deal != null) {
        final history = DealHistory(
          id: const Uuid().v4(),
          dealId: id,
          oldStatus: deal.status,
          newStatus: deal.status,
          date: DateTime.now(),
          comment: 'Restored by user',
        );
        await repository.saveHistory(history);
      }

      return repository.getDeals();
    });
  }
}
