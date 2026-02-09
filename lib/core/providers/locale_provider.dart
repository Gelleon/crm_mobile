import 'dart:ui';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

@riverpod
class LocaleController extends _$LocaleController {
  @override
  Locale? build() {
    return const Locale('ru');
  }

  void setLocale(Locale? locale) {
    state = locale;
  }
}
