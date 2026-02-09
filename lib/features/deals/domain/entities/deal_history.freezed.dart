// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deal_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DealHistory _$DealHistoryFromJson(Map<String, dynamic> json) {
  return _DealHistory.fromJson(json);
}

/// @nodoc
mixin _$DealHistory {
  String get id => throw _privateConstructorUsedError;
  String get dealId => throw _privateConstructorUsedError;
  DealStatus get oldStatus => throw _privateConstructorUsedError;
  DealStatus get newStatus => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DealHistoryCopyWith<DealHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealHistoryCopyWith<$Res> {
  factory $DealHistoryCopyWith(
          DealHistory value, $Res Function(DealHistory) then) =
      _$DealHistoryCopyWithImpl<$Res, DealHistory>;
  @useResult
  $Res call(
      {String id,
      String dealId,
      DealStatus oldStatus,
      DealStatus newStatus,
      DateTime date,
      String? comment});
}

/// @nodoc
class _$DealHistoryCopyWithImpl<$Res, $Val extends DealHistory>
    implements $DealHistoryCopyWith<$Res> {
  _$DealHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dealId = null,
    Object? oldStatus = null,
    Object? newStatus = null,
    Object? date = null,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dealId: null == dealId
          ? _value.dealId
          : dealId // ignore: cast_nullable_to_non_nullable
              as String,
      oldStatus: null == oldStatus
          ? _value.oldStatus
          : oldStatus // ignore: cast_nullable_to_non_nullable
              as DealStatus,
      newStatus: null == newStatus
          ? _value.newStatus
          : newStatus // ignore: cast_nullable_to_non_nullable
              as DealStatus,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DealHistoryImplCopyWith<$Res>
    implements $DealHistoryCopyWith<$Res> {
  factory _$$DealHistoryImplCopyWith(
          _$DealHistoryImpl value, $Res Function(_$DealHistoryImpl) then) =
      __$$DealHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String dealId,
      DealStatus oldStatus,
      DealStatus newStatus,
      DateTime date,
      String? comment});
}

/// @nodoc
class __$$DealHistoryImplCopyWithImpl<$Res>
    extends _$DealHistoryCopyWithImpl<$Res, _$DealHistoryImpl>
    implements _$$DealHistoryImplCopyWith<$Res> {
  __$$DealHistoryImplCopyWithImpl(
      _$DealHistoryImpl _value, $Res Function(_$DealHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dealId = null,
    Object? oldStatus = null,
    Object? newStatus = null,
    Object? date = null,
    Object? comment = freezed,
  }) {
    return _then(_$DealHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dealId: null == dealId
          ? _value.dealId
          : dealId // ignore: cast_nullable_to_non_nullable
              as String,
      oldStatus: null == oldStatus
          ? _value.oldStatus
          : oldStatus // ignore: cast_nullable_to_non_nullable
              as DealStatus,
      newStatus: null == newStatus
          ? _value.newStatus
          : newStatus // ignore: cast_nullable_to_non_nullable
              as DealStatus,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DealHistoryImpl implements _DealHistory {
  const _$DealHistoryImpl(
      {required this.id,
      required this.dealId,
      required this.oldStatus,
      required this.newStatus,
      required this.date,
      this.comment});

  factory _$DealHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DealHistoryImplFromJson(json);

  @override
  final String id;
  @override
  final String dealId;
  @override
  final DealStatus oldStatus;
  @override
  final DealStatus newStatus;
  @override
  final DateTime date;
  @override
  final String? comment;

  @override
  String toString() {
    return 'DealHistory(id: $id, dealId: $dealId, oldStatus: $oldStatus, newStatus: $newStatus, date: $date, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DealHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dealId, dealId) || other.dealId == dealId) &&
            (identical(other.oldStatus, oldStatus) ||
                other.oldStatus == oldStatus) &&
            (identical(other.newStatus, newStatus) ||
                other.newStatus == newStatus) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, dealId, oldStatus, newStatus, date, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DealHistoryImplCopyWith<_$DealHistoryImpl> get copyWith =>
      __$$DealHistoryImplCopyWithImpl<_$DealHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DealHistoryImplToJson(
      this,
    );
  }
}

abstract class _DealHistory implements DealHistory {
  const factory _DealHistory(
      {required final String id,
      required final String dealId,
      required final DealStatus oldStatus,
      required final DealStatus newStatus,
      required final DateTime date,
      final String? comment}) = _$DealHistoryImpl;

  factory _DealHistory.fromJson(Map<String, dynamic> json) =
      _$DealHistoryImpl.fromJson;

  @override
  String get id;
  @override
  String get dealId;
  @override
  DealStatus get oldStatus;
  @override
  DealStatus get newStatus;
  @override
  DateTime get date;
  @override
  String? get comment;
  @override
  @JsonKey(ignore: true)
  _$$DealHistoryImplCopyWith<_$DealHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
