import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crm_mobile/l10n/app_localizations.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/biometric_service.dart';

@RoutePage()
class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  bool _canCheckBiometrics = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkBiometrics();
    });
  }

  Future<void> _checkBiometrics() async {
    final secureStorage = getIt<SecureStorageService>();
    final isEnabled = await secureStorage.isBiometricEnabled();

    if (!isEnabled) {
      _navigateToHome();
      return;
    }

    final service = getIt<BiometricService>();
    final available = await service.isAvailable();
    setState(() {
      _canCheckBiometrics = available;
    });
    if (available) {
      _authenticate();
    } else {
      // If no biometrics, proceed to home (or ask for PIN if implemented)
      // For now, proceed.
      _navigateToHome();
    }
  }

  Future<void> _authenticate() async {
    final service = getIt<BiometricService>();
    final authenticated = await service.authenticate();
    if (authenticated) {
      _navigateToHome();
    } else {
      setState(() {
        _hasError = true;
      });
    }
  }

  void _navigateToHome() {
    context.router.replace(const HomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 64),
            const SizedBox(height: 16),
            Text(_hasError ? l10n.authFailed : l10n.authenticating),
            if (_canCheckBiometrics && _hasError)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: _authenticate,
                  child: Text(l10n.retry),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
