import 'package:freezed_annotation/freezed_annotation.dart';

part 'interaction.freezed.dart';
part 'interaction.g.dart';

enum InteractionType {
  call,
  meeting,
  note,
  other;

  String get label {
    switch (this) {
      case InteractionType.call:
        return 'Звонок';
      case InteractionType.meeting:
        return 'Встреча';
      case InteractionType.note:
        return 'Заметка';
      case InteractionType.other:
        return 'Другое';
    }
  }
}

@freezed
class Interaction with _$Interaction {
  const factory Interaction({
    required String id,
    required String clientId,
    required InteractionType type,
    required DateTime date,
    required String notes,
  }) = _Interaction;

  factory Interaction.fromJson(Map<String, dynamic> json) =>
      _$InteractionFromJson(json);
}
