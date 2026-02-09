import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crm_mobile/l10n/app_localizations.dart';
import '../providers/clients_provider.dart';
import '../../../../core/router/app_router.gr.dart';

@RoutePage()
class ClientsPage extends HookConsumerWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientsAsync = ref.watch(clientsProvider);
    final searchController = useTextEditingController();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(ClientFormRoute()),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref.read(clientsProvider.notifier).searchClients(value);
              },
            ),
          ),
          Expanded(
            child: clientsAsync.when(
              data: (clients) {
                if (clients.isEmpty) {
                  return Center(child: Text(l10n.noClientsFound));
                }
                return ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    final client = clients[index];
                    return ListTile(
                      title: Text(client.name),
                      subtitle: Text(client.phone),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.router.push(
                        ClientDetailsRoute(client: client),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) =>
                  Center(child: Text(l10n.error(err.toString()))),
            ),
          ),
        ],
      ),
    );
  }
}
