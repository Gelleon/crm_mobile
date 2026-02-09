// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InteractionImpl _$$InteractionImplFromJson(Map<String, dynamic> json) =>
    _$InteractionImpl(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      type: $enumDecode(_$InteractionTypeEnumMap, json['type']),
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$$InteractionImplToJson(_$InteractionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'type': _$InteractionTypeEnumMap[instance.type]!,
      'date': instance.date.toIso8601String(),
      'notes': instance.notes,
    };

const _$InteractionTypeEnumMap = {
  InteractionType.call: 'call',
  InteractionType.meeting: 'meeting',
  InteractionType.note: 'note',
  InteractionType.other: 'other',
};
