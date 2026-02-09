import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/client.dart';
import '../../domain/entities/interaction.dart';
import '../providers/clients_provider.dart';
import '../providers/interactions_provider.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/di/injection.dart';
import 'package:crm_mobile/l10n/app_localizations.dart';

import 'package:crm_mobile/features/deals/presentation/providers/deals_provider.dart';
import 'package:crm_mobile/features/deals/domain/entities/deal.dart';
import 'package:crm_mobile/features/deals/domain/entities/deal_status.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/speech_service.dart';

@RoutePage()
class ClientDetailsPage extends HookConsumerWidget {
  final Client client;

  const ClientDetailsPage({super.key, required this.client});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveClient = ref.watch(clientProvider(client.id)) ?? client;
    final tabController = useTabController(initialLength: 3);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(liveClient.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () =>
                context.router.push(ClientFormRoute(client: liveClient)),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: l10n.info),
            Tab(text: l10n.history),
            Tab(text: l10n.deals),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          _ClientInfoTab(client: liveClient),
          _ClientHistoryTab(clientId: liveClient.id),
          _ClientDealsTab(client: liveClient),
        ],
      ),
    );
  }
}

String _getInteractionLabel(InteractionType type, AppLocalizations l10n) {
  switch (type) {
    case InteractionType.call:
      return l10n.interactionCall;
    case InteractionType.meeting:
      return l10n.interactionMeeting;
    case InteractionType.note:
      return l10n.interactionNote;
    case InteractionType.other:
      return l10n.interactionOther;
  }
}

class _ClientInfoTab extends StatelessWidget {
  final Client client;

  const _ClientInfoTab({required this.client});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        _InfoRow(
          icon: Icons.phone,
          label: l10n.clientPhone,
          value: client.phone,
          onTap: () => launchUrl(Uri.parse('tel:${client.phone}')),
        ),
        const Divider(),
        _InfoRow(
          icon: Icons.email,
          label: l10n.clientEmail,
          value: client.email,
          onTap: () => launchUrl(Uri.parse('mailto:${client.email}')),
        ),
        const Divider(),
        _InfoRow(
          icon: Icons.location_on,
          label: l10n.clientAddress,
          value: client.address,
          onTap: () => launchUrl(
            Uri.parse(
              'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(client.address)}',
            ),
          ),
        ),
        const Divider(),
        _InfoRow(
          icon: Icons.comment,
          label: l10n.clientComment,
          value: client.comment,
        ),
        const Divider(),
        _InfoRow(
          icon: Icons.calendar_today,
          label: l10n.createdAt,
          value: DateFormat('yyyy-MM-dd HH:mm').format(client.createdAt),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.grey),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const Gap(4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: onTap != null ? Colors.blue : null,
                      decoration: onTap != null
                          ? TextDecoration.underline
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClientHistoryTab extends ConsumerWidget {
  final String clientId;

  const _ClientHistoryTab({required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interactionsAsync = ref.watch(clientInteractionsProvider(clientId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddInteractionDialog(context, ref, clientId),
        child: const Icon(Icons.add),
      ),
      body: interactionsAsync.when(
        data: (interactions) {
          if (interactions.isEmpty) {
            return Center(child: Text(l10n.noInteractionHistory));
          }
          return ListView.builder(
            itemCount: interactions.length,
            padding: const EdgeInsets.only(bottom: 80),
            itemBuilder: (context, index) {
              final item = interactions[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getColorForType(item.type),
                    child: Icon(
                      _getIconForType(item.type),
                      color: Colors.white,
                    ),
                  ),
                  title: Text(_getInteractionLabel(item.type, l10n)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.notes),
                      const Gap(4),
                      Text(
                        DateFormat('yyyy-MM-dd HH:mm').format(item.date),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () => ref
                        .read(clientInteractionsProvider(clientId).notifier)
                        .deleteInteraction(item.id),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(l10n.error(err.toString()))),
      ),
    );
  }

  Color _getColorForType(InteractionType type) {
    switch (type) {
      case InteractionType.call:
        return Colors.green;
      case InteractionType.meeting:
        return Colors.blue;
      case InteractionType.note:
        return Colors.orange;
      case InteractionType.other:
        return Colors.grey;
    }
  }

  IconData _getIconForType(InteractionType type) {
    switch (type) {
      case InteractionType.call:
        return Icons.phone;
      case InteractionType.meeting:
        return Icons.people;
      case InteractionType.note:
        return Icons.note;
      case InteractionType.other:
        return Icons.info;
    }
  }

  void _showAddInteractionDialog(
    BuildContext context,
    WidgetRef ref,
    String clientId,
  ) {
    showDialog(
      context: context,
      builder: (context) => _AddInteractionDialog(clientId: clientId),
    );
  }
}

class _AddInteractionDialog extends HookConsumerWidget {
  final String clientId;

  const _AddInteractionDialog({required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final type = useState(InteractionType.call);
    final date = useState(DateTime.now());
    final notesController = useTextEditingController();
    final remind = useState(false);
    final isListening = useState(false);

    return AlertDialog(
      title: Text(l10n.addInteraction),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<InteractionType>(
              initialValue: type.value,
              decoration: InputDecoration(labelText: l10n.type),
              items: InteractionType.values
                  .map(
                    (t) => DropdownMenuItem(
                      value: t,
                      child: Text(_getInteractionLabel(t, l10n)),
                    ),
                  )
                  .toList(),
              onChanged: (val) => type.value = val!,
            ),
            const Gap(16),
            TextFormField(
              controller: notesController,
              decoration: InputDecoration(
                labelText: l10n.notes,
                suffixIcon: IconButton(
                  icon: Icon(isListening.value ? Icons.mic_off : Icons.mic),
                  color: isListening.value ? Colors.red : null,
                  onPressed: () async {
                    final speech = getIt<SpeechService>();
                    if (isListening.value) {
                      await speech.stopListening();
                      isListening.value = false;
                    } else {
                      isListening.value = true;
                      await speech.startListening(
                        onResult: (text) {
                          notesController.text = text;
                        },
                      );
                    }
                  },
                ),
              ),
              maxLines: 3,
            ),
            const Gap(16),
            InkWell(
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: date.value,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (d != null) {
                  final t = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(date.value),
                  );
                  if (t != null) {
                    date.value = DateTime(
                      d.year,
                      d.month,
                      d.day,
                      t.hour,
                      t.minute,
                    );
                  }
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(labelText: l10n.dateTime),
                child: Text(DateFormat('yyyy-MM-dd HH:mm').format(date.value)),
              ),
            ),
            CheckboxListTile(
              title: Text(l10n.remindMe),
              value: remind.value,
              onChanged: (val) => remind.value = val ?? false,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            if (notesController.text.isEmpty) return;
            final interaction = Interaction(
              id: const Uuid().v4(),
              clientId: clientId,
              type: type.value,
              date: date.value,
              notes: notesController.text,
            );

            if (remind.value) {
              await getIt<NotificationService>().scheduleNotification(
                id: interaction.hashCode,
                title: l10n.interactionReminder(
                  _getInteractionLabel(type.value, l10n),
                ),
                body: notesController.text,
                scheduledDate: date.value,
              );
            }

            ref
                .read(clientInteractionsProvider(clientId).notifier)
                .addInteraction(interaction);
            Navigator.pop(context);
          },
          child: Text(l10n.add),
        ),
      ],
    );
  }
}

class _ClientDealsTab extends ConsumerWidget {
  final Client client;

  const _ClientDealsTab({required this.client});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dealsAsync = ref.watch(dealsProvider);
    final currencyFormat = NumberFormat.currency(
      locale: 'ru',
      symbol: '₽',
      decimalDigits: 2,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'addDealFab',
        onPressed: () =>
            context.router.push(DealFormRoute(initialClientId: client.id)),
        child: const Icon(Icons.add),
      ),
      body: dealsAsync.when(
        data: (allDeals) {
          final clientDeals = allDeals
              .where((d) => d.clientId == client.id)
              .toList();

          if (clientDeals.isEmpty) {
            return Center(child: Text(l10n.noDealsFound));
          }

          return ListView.builder(
            itemCount: clientDeals.length,
            padding: const EdgeInsets.only(bottom: 80),
            itemBuilder: (context, index) {
              final deal = clientDeals[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('${l10n.dealTitle}-${client.name}'),
                  subtitle: Text(
                    '${deal.status.label} - ${DateFormat.yMMMd('ru').format(deal.createdAt)}',
                  ),
                  trailing: Text(currencyFormat.format(deal.totalAmount)),
                  onTap: () => context.router.push(DealFormRoute(deal: deal)),
                  onLongPress: () {
                    final parentContext = context;
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.edit),
                              title: Text(l10n.editDeal),
                              onTap: () {
                                Navigator.pop(context);
                                context.router.push(DealFormRoute(deal: deal));
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              title: Text(
                                l10n.deleteDealTitle,
                                style: const TextStyle(color: Colors.red),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                showDialog(
                                  context: parentContext,
                                  builder: (context) => AlertDialog(
                                    title: Text(l10n.deleteDealTitle),
                                    content: Text(l10n.deleteDealConfirmation),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(l10n.cancel),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          ref
                                              .read(dealsProvider.notifier)
                                              .deleteDeal(deal.id);

                                          if (parentContext.mounted) {
                                            final messenger =
                                                ScaffoldMessenger.of(
                                                  parentContext,
                                                );
                                            messenger.hideCurrentSnackBar();
                                            messenger.showSnackBar(
                                              SnackBar(
                                                content: Text(l10n.dealDeleted),
                                                duration: const Duration(
                                                  seconds: 4,
                                                ),
                                                action: SnackBarAction(
                                                  label: l10n.undo,
                                                  onPressed: () {
                                                    ref
                                                        .read(
                                                          dealsProvider
                                                              .notifier,
                                                        )
                                                        .restoreDeal(deal.id);
                                                  },
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          l10n.deleteDealTitle,
                                          style: const TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(l10n.error(err.toString()))),
      ),
    );
  }
}
