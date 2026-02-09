import 'package:freezed_annotation/freezed_annotation.dart';

part 'client.freezed.dart';
part 'client.g.dart';

@freezed
class Client with _$Client {
  const factory Client({
    required String id,
    required String name,
    required String phone,
    required String email,
    required String address,
    required String comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Client;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
}
