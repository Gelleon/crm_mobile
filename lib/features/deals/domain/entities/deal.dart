import 'package:freezed_annotation/freezed_annotation.dart';
import 'product.dart';
import 'deal_status.dart';

part 'deal.freezed.dart';
part 'deal.g.dart';

@freezed
class Deal with _$Deal {
  const Deal._();

  const factory Deal({
    required String id,
    required String clientId,
    required List<Product> products,
    required DealStatus status,
    required DateTime createdAt,
    DateTime? paymentDate,
    required double totalAmount,
    @Default(false) bool isDeleted,
    String? description,
    String? authorId,
  }) = _Deal;

  factory Deal.fromJson(Map<String, dynamic> json) => _$DealFromJson(json);

  bool get isInTurnover => status.isSuccessful && paymentDate != null;

  String get title {
    return 'Сделка';
  }
}
