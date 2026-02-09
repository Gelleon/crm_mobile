import 'package:crm_mobile/core/services/auth_service.dart';
import 'package:crm_mobile/core/di/injection.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:crm_mobile/l10n/app_localizations.dart';
import '../providers/deals_provider.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../clients/presentation/providers/clients_provider.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../domain/entities/deal.dart';
import '../../../clients/domain/entities/client.dart';

@RoutePage()
class DealsPage extends ConsumerWidget {
  const DealsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealsAsync = ref.watch(dealsProvider);
    final clientsAsync = ref.watch(clientsProvider);
    final settingsState = ref.watch(settingsProvider);
    final l10n = AppLocalizations.of(context)!;
    final currencyFormat = NumberFormat.currency(
      locale: 'ru',
      symbol: '₽',
      decimalDigits: 2,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(DealFormRoute()),
        child: const Icon(Icons.add),
      ),
      body: dealsAsync.when(
        data: (deals) {
          if (deals.isEmpty) {
            return Center(child: Text(l10n.noDataForPeriod));
          }
          return ListView.builder(
            itemCount: deals.length,
            itemBuilder: (context, index) {
              final deal = deals[index];
              return FutureBuilder<bool>(
                future: getIt<AuthService>().canDeleteDeal(deal.authorId),
                builder: (context, snapshot) {
                  final canDelete = snapshot.data ?? false;

                  // Resolve Client Name
                  final client = clientsAsync.valueOrNull
                      ?.where((c) => c.id == deal.clientId)
                      .firstOrNull;
                  final clientName = client?.name;

                  // Resolve Title
                  String title;
                  final template = settingsState.dealTitleTemplate;
                  if (template.isNotEmpty) {
                    title = _formatDealTitle(template, deal, clientName);
                  } else {
                    title = '${l10n.dealTitle}-${clientName ?? "?"}';
                  }

                  return ListTile(
                    title: Text(title),
                    subtitle: Text(
                      '${deal.status.label} - ${DateFormat.yMMMd('ru').format(deal.createdAt)}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(currencyFormat.format(deal.totalAmount)),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              context.router.push(DealFormRoute(deal: deal));
                            } else if (value == 'delete') {
                              ref
                                  .read(dealsProvider.notifier)
                                  .deleteDeal(deal.id);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Text(l10n.editDeal),
                            ),
                            if (canDelete)
                              PopupMenuItem(
                                value: 'delete',
                                child: Text(
                                  l10n.deleteDeal,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () => context.router.push(DealFormRoute(deal: deal)),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(l10n.error(err.toString()))),
      ),
    );
  }

  String _formatDealTitle(String template, Deal deal, String? clientName) {
    var title = template;
    title = title.replaceAll('{id}', deal.id.substring(0, 8));
    title = title.replaceAll(
      '{date}',
      DateFormat('yyyy-MM-dd').format(deal.createdAt),
    );
    title = title.replaceAll('{client}', clientName ?? '?');
    title = title.replaceAll('{amount}', deal.totalAmount.toStringAsFixed(0));
    return title;
  }
}
