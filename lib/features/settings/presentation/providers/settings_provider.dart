import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/di/injection.dart';

class SettingsState {
  final String dealTitleTemplate;
  final bool isLoading;

  const SettingsState({
    required this.dealTitleTemplate,
    this.isLoading = false,
  });

  SettingsState copyWith({String? dealTitleTemplate, bool? isLoading}) {
    return SettingsState(
      dealTitleTemplate: dealTitleTemplate ?? this.dealTitleTemplate,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier()
      : super(const SettingsState(dealTitleTemplate: 'Сделка-{client}')) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    state = state.copyWith(isLoading: true);
    final storage = getIt<SecureStorageService>();
    final template = await storage.getDealTitleTemplate();
    state = state.copyWith(
      dealTitleTemplate: template ?? 'Сделка-{client}',
      isLoading: false,
    );
  }

  Future<void> saveDealTitleTemplate(String template) async {
    state = state.copyWith(isLoading: true);
    final storage = getIt<SecureStorageService>();
    await storage.saveDealTitleTemplate(template);
    state = state.copyWith(dealTitleTemplate: template, isLoading: false);
  }

  Future<void> resetToDefault() async {
    await saveDealTitleTemplate('Сделка-{client}');
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) {
    return SettingsNotifier();
  },
);
