import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:crm_mobile/l10n/app_localizations.dart';
import '../../../../core/router/app_router.gr.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AutoTabsScaffold(
      appBarBuilder: (_, tabsRouter) => AppBar(
        title: Text(
          tabsRouter.current.name == 'ClientsRoute'
              ? l10n.clients
              : tabsRouter.current.name == 'DealsRoute'
              ? l10n.deals
              : l10n.analytics,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.router.push(const SettingsRoute()),
          ),
        ],
      ),
      routes: const [ClientsRoute(), DealsRoute(), AnalyticsRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          destinations: [
            NavigationDestination(
              label: l10n.clients,
              icon: const Icon(Icons.people),
            ),
            NavigationDestination(
              label: l10n.deals,
              icon: const Icon(Icons.attach_money),
            ),
            NavigationDestination(
              label: l10n.analytics,
              icon: const Icon(Icons.analytics),
            ),
          ],
        );
      },
    );
  }
}
