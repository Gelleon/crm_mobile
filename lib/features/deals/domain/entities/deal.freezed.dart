// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Deal _$DealFromJson(Map<String, dynamic> json) {
  return _Deal.fromJson(json);
}

/// @nodoc
mixin _$Deal {
  String get id => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  List<Product> get products => throw _privateConstructorUsedError;
  DealStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get paymentDate => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get authorId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DealCopyWith<Deal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealCopyWith<$Res> {
  factory $DealCopyWith(Deal value, $Res Function(Deal) then) =
      _$DealCopyWithImpl<$Res, Deal>;
  @useResult
  $Res call(
      {String id,
      String clientId,
      List<Product> products,
      DealStatus status,
      DateTime createdAt,
      DateTime? paymentDate,
      double totalAmount,
      bool isDeleted,
      String? description,
      String? authorId});
}

/// @nodoc
class _$DealCopyWithImpl<$Res, $Val extends Deal>
    implements $DealCopyWith<$Res> {
  _$DealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? products = null,
    Object? status = null,
    Object? createdAt = null,
    Object? paymentDate = freezed,
    Object? totalAmount = null,
    Object? isDeleted = null,
    Object? description = freezed,
    Object? authorId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DealStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DealImplCopyWith<$Res> implements $DealCopyWith<$Res> {
  factory _$$DealImplCopyWith(
          _$DealImpl value, $Res Function(_$DealImpl) then) =
      __$$DealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String clientId,
      List<Product> products,
      DealStatus status,
      DateTime createdAt,
      DateTime? paymentDate,
      double totalAmount,
      bool isDeleted,
      String? description,
      String? authorId});
}

/// @nodoc
class __$$DealImplCopyWithImpl<$Res>
    extends _$DealCopyWithImpl<$Res, _$DealImpl>
    implements _$$DealImplCopyWith<$Res> {
  __$$DealImplCopyWithImpl(_$DealImpl _value, $Res Function(_$DealImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? products = null,
    Object? status = null,
    Object? createdAt = null,
    Object? paymentDate = freezed,
    Object? totalAmount = null,
    Object? isDeleted = null,
    Object? description = freezed,
    Object? authorId = freezed,
  }) {
    return _then(_$DealImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DealStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DealImpl extends _Deal {
  const _$DealImpl(
      {required this.id,
      required this.clientId,
      required final List<Product> products,
      required this.status,
      required this.createdAt,
      this.paymentDate,
      required this.totalAmount,
      this.isDeleted = false,
      this.description,
      this.authorId})
      : _products = products,
        super._();

  factory _$DealImpl.fromJson(Map<String, dynamic> json) =>
      _$$DealImplFromJson(json);

  @override
  final String id;
  @override
  final String clientId;
  final List<Product> _products;
  @override
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  final DealStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? paymentDate;
  @override
  final double totalAmount;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final String? description;
  @override
  final String? authorId;

  @override
  String toString() {
    return 'Deal(id: $id, clientId: $clientId, products: $products, status: $status, createdAt: $createdAt, paymentDate: $paymentDate, totalAmount: $totalAmount, isDeleted: $isDeleted, description: $description, authorId: $authorId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DealImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      clientId,
      const DeepCollectionEquality().hash(_products),
      status,
      createdAt,
      paymentDate,
      totalAmount,
      isDeleted,
      description,
      authorId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DealImplCopyWith<_$DealImpl> get copyWith =>
      __$$DealImplCopyWithImpl<_$DealImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DealImplToJson(
      this,
    );
  }
}

abstract class _Deal extends Deal {
  const factory _Deal(
      {required final String id,
      required final String clientId,
      required final List<Product> products,
      required final DealStatus status,
      required final DateTime createdAt,
      final DateTime? paymentDate,
      required final double totalAmount,
      final bool isDeleted,
      final String? description,
      final String? authorId}) = _$DealImpl;
  const _Deal._() : super._();

  factory _Deal.fromJson(Map<String, dynamic> json) = _$DealImpl.fromJson;

  @override
  String get id;
  @override
  String get clientId;
  @override
  List<Product> get products;
  @override
  DealStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get paymentDate;
  @override
  double get totalAmount;
  @override
  bool get isDeleted;
  @override
  String? get description;
  @override
  String? get authorId;
  @override
  @JsonKey(ignore: true)
  _$$DealImplCopyWith<_$DealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
