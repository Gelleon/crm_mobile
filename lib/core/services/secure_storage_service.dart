import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  Future<void> saveTargetTurnover(double target) async {
    await _storage.write(key: 'target_turnover', value: target.toString());
  }

  Future<double?> getTargetTurnover() async {
    final str = await _storage.read(key: 'target_turnover');
    return str != null ? double.tryParse(str) : null;
  }

  Future<void> saveBiometricEnabled(bool enabled) async {
    await _storage.write(key: 'biometric_enabled', value: enabled.toString());
  }

  Future<bool> isBiometricEnabled() async {
    final str = await _storage.read(key: 'biometric_enabled');
    return str == 'true';
  }

  Future<void> saveDealTitleTemplate(String template) async {
    await _storage.write(key: 'deal_title_template', value: template);
  }

  Future<String?> getDealTitleTemplate() async {
    return await _storage.read(key: 'deal_title_template');
  }
}
