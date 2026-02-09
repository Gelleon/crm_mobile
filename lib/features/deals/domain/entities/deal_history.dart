import 'package:freezed_annotation/freezed_annotation.dart';
import 'deal_status.dart';

part 'deal_history.freezed.dart';
part 'deal_history.g.dart';

@freezed
class DealHistory with _$DealHistory {
  const factory DealHistory({
    required String id,
    required String dealId,
    required DealStatus oldStatus,
    required DealStatus newStatus,
    required DateTime date,
    String? comment,
  }) = _DealHistory;

  factory DealHistory.fromJson(Map<String, dynamic> json) =>
      _$DealHistoryFromJson(json);
}
