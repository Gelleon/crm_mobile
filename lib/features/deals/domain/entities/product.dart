import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const Product._();

  const factory Product({
    required String id,
    required String name,
    required String description,
    required double price,
    @Default(0.0) double costPrice,
    @Default(0.0) double discount,
    @Default(0.0) double tax,
    required int quantity,
    String? photoPath,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  double get priceWithDiscount => price * (1 - discount / 100);
  double get priceWithTax => priceWithDiscount * (1 + tax / 100);
  double get total => priceWithTax * quantity;
  double get totalCost => costPrice * quantity;
  double get profit => total - totalCost;
  double get margin => total > 0 ? (profit / total) * 100 : 0;
}
