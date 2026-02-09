import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import '../../../../core/di/injection.dart';
import '../../services/pdf_service.dart';
import '../../../deals/domain/entities/deal.dart';
import '../../../clients/domain/entities/client.dart';
import '../../../clients/domain/entities/interaction.dart';
import '../../../clients/presentation/providers/interactions_provider.dart';
import 'package:crm_mobile/l10n/app_localizations.dart';

class ContractGenerationPage extends ConsumerStatefulWidget {
  final Deal deal;
  final Client client;

  const ContractGenerationPage({
    super.key,
    required this.deal,
    required this.client,
  });

  @override
  ConsumerState<ContractGenerationPage> createState() =>
      _ContractGenerationPageState();
}

class _ContractGenerationPageState
    extends ConsumerState<ContractGenerationPage> {
  late DateTime _contractDate;
  String? _conditions;
  final _conditionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contractDate = DateTime.now();
  }

  @override
  void dispose() {
    _conditionsController.dispose();
    super.dispose();
  }

  Future<void> _showSettingsDialog() async {
    final l10n = AppLocalizations.of(context)!;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.contractSettings ?? 'Настройки договора'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(l10n.date),
              subtitle: Text(DateFormat('dd.MM.yyyy').format(_contractDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _contractDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    _contractDate = picked;
                  });
                  Navigator.pop(context);
                  _showSettingsDialog(); // Reopen to show updated date
                }
              },
            ),
            const Gap(10),
            TextField(
              controller: _conditionsController,
              decoration: InputDecoration(
                labelText: l10n.conditions ?? 'Дополнительные условия',
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                _conditions = _conditionsController.text;
              });
              Navigator.pop(context);
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Validation check
    if (widget.deal.products.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.contract)),
        body: Center(
          child: Text(l10n.noProductsInDeal ?? 'В сделке нет товаров'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.contract),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settings,
            onPressed: _showSettingsDialog,
          ),
        ],
      ),
      body: PdfPreview(
        build: (format) async {
          final pdfService = getIt<PdfService>();
          final file = await pdfService.generateContract(
            widget.deal,
            widget.client,
            conditions: _conditions,
            date: _contractDate,
          );
          return file.readAsBytes();
        },
        canChangeOrientation: false,
        canChangePageFormat: false,
        pdfFileName: 'contract_${widget.deal.id}.pdf',
        actions: [
          PdfPreviewAction(
            icon: const Icon(Icons.history),
            onPressed: (context, build, pageFormat) async {
              // Regenerate to save (or we could cache it, but regeneration is fast enough)
              final pdfService = getIt<PdfService>();
              final file = await pdfService.generateContract(
                widget.deal,
                widget.client,
                conditions: _conditions,
                date: _contractDate,
              );

              // Save to permanent storage
              final appDocDir = await getApplicationDocumentsDirectory();
              final permPath =
                  '${appDocDir.path}/contract_${widget.deal.id}_${DateTime.now().millisecondsSinceEpoch}.pdf';
              await file.copy(permPath);

              // Add interaction
              final interaction = Interaction(
                id: const Uuid().v4(),
                clientId: widget.client.id,
                type: InteractionType.note, // Using 'note' as closest type
                date: DateTime.now(),
                notes: 'Сформирован договор. Файл сохранен: $permPath',
              );

              await ref
                  .read(clientInteractionsProvider(widget.client.id).notifier)
                  .addInteraction(interaction);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      l10n.contractSaved ?? 'Договор сохранен в истории',
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
