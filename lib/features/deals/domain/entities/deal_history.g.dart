// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DealHistoryImpl _$$DealHistoryImplFromJson(Map<String, dynamic> json) =>
    _$DealHistoryImpl(
      id: json['id'] as String,
      dealId: json['dealId'] as String,
      oldStatus: $enumDecode(_$DealStatusEnumMap, json['oldStatus']),
      newStatus: $enumDecode(_$DealStatusEnumMap, json['newStatus']),
      date: DateTime.parse(json['date'] as String),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$$DealHistoryImplToJson(_$DealHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dealId': instance.dealId,
      'oldStatus': _$DealStatusEnumMap[instance.oldStatus]!,
      'newStatus': _$DealStatusEnumMap[instance.newStatus]!,
      'date': instance.date.toIso8601String(),
      'comment': instance.comment,
    };

const _$DealStatusEnumMap = {
  DealStatus.inProgress: 'inProgress',
  DealStatus.quoteSent: 'quoteSent',
  DealStatus.rejected: 'rejected',
  DealStatus.paid: 'paid',
  DealStatus.completed: 'completed',
};
