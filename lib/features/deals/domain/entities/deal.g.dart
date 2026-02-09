// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DealImpl _$$DealImplFromJson(Map<String, dynamic> json) => _$DealImpl(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecode(_$DealStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      paymentDate: json['paymentDate'] == null
          ? null
          : DateTime.parse(json['paymentDate'] as String),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      isDeleted: json['isDeleted'] as bool? ?? false,
      description: json['description'] as String?,
      authorId: json['authorId'] as String?,
    );

Map<String, dynamic> _$$DealImplToJson(_$DealImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'products': instance.products,
      'status': _$DealStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'paymentDate': instance.paymentDate?.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'isDeleted': instance.isDeleted,
      'description': instance.description,
      'authorId': instance.authorId,
    };

const _$DealStatusEnumMap = {
  DealStatus.inProgress: 'inProgress',
  DealStatus.quoteSent: 'quoteSent',
  DealStatus.rejected: 'rejected',
  DealStatus.paid: 'paid',
  DealStatus.completed: 'completed',
};
