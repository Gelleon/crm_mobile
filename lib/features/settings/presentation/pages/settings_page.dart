import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:crm_mobile/l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import '../providers/settings_provider.dart';

@RoutePage()
class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settingsState = ref.watch(settingsProvider);
    final controller = useTextEditingController(
      text: settingsState.dealTitleTemplate,
    );

    // Update controller when state changes (e.g. initial load or reset)
    useEffect(() {
      if (controller.text != settingsState.dealTitleTemplate) {
        controller.text = settingsState.dealTitleTemplate;
      }
      return null;
    }, [settingsState.dealTitleTemplate]);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            l10n.dealTitleTemplate,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Gap(8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: l10n.dealTitleTemplateHint,
              border: const OutlineInputBorder(),
              helperText: l10n.dealTitleTemplateHint,
              helperMaxLines: 2,
            ),
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  ref.read(settingsProvider.notifier).resetToDefault();
                },
                child: Text(l10n.resetToDefault),
              ),
              const Gap(8),
              FilledButton(
                onPressed: () {
                  ref
                      .read(settingsProvider.notifier)
                      .saveDealTitleTemplate(controller.text);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(l10n.templateSaved)));
                },
                child: Text(l10n.save),
              ),
            ],
          ),
          const Divider(height: 32),
          // Language section (kept from previous version)
          ListTile(
            title: Text(l10n.language),
            subtitle: Text(l10n.russian),
            enabled: false,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
