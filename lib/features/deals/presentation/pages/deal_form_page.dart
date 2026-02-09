import 'package:intl/intl.dart'; // Added for DateFormat
import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';
import 'package:signature/signature.dart';
import '../../domain/entities/deal_history.dart'; // Added for DealHistory
import '../../domain/repositories/deals_repository.dart'; // Added for DealsRepository
import '../../../../core/di/injection.dart'; // Already imported but ensuring visibility
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:gap/gap.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import '../../domain/entities/deal.dart';
import '../../domain/entities/deal_status.dart';
import '../../domain/entities/product.dart';
import '../providers/deals_provider.dart';
import '../../../clients/presentation/providers/clients_provider.dart';
import 'package:crm_mobile/features/documents/services/pdf_service.dart';
import 'package:crm_mobile/core/services/speech_service.dart';
import 'package:crm_mobile/l10n/app_localizations.dart';

import 'package:crm_mobile/features/deals/services/draft_service.dart';
import 'package:crm_mobile/core/services/auth_service.dart';
import 'dart:convert'; // For jsonDecode if needed
import 'dart:async'; // For Timer

@RoutePage()
class DealFormPage extends HookConsumerWidget {
  final Deal? deal;
  final String? initialClientId;

  const DealFormPage({super.key, this.deal, this.initialClientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currencyFormat = NumberFormat.currency(
      locale: 'ru',
      symbol: '₽',
      decimalDigits: 2,
    );
    final products = useState<List<Product>>(deal?.products ?? []);
    final selectedClientId = useState<String?>(
      deal?.clientId ?? initialClientId,
    );
    final status = useState<DealStatus>(deal?.status ?? DealStatus.inProgress);
    final descriptionController = useTextEditingController(
      text: deal?.description,
    );
    final clientsAsync = ref.watch(clientsProvider);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Access Control
    final canEditFuture = useMemoized(
      () => getIt<AuthService>().canEditDeal(deal?.authorId),
    );
    final canEditSnapshot = useFuture(canEditFuture, initialData: false);
    final canEdit = canEditSnapshot.data ?? false;

    // Auto-save logic (for new deals only for now)
    useEffect(() {
      if (deal == null) {
        // Check for draft
        getIt<DraftService>().getDraft('new_deal').then((data) {
          if (data != null && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.foundSavedDraft),
                duration: const Duration(seconds: 10),
                action: SnackBarAction(
                  label: l10n.restore,
                  onPressed: () {
                    try {
                      if (data['clientId'] != null) {
                        selectedClientId.value = data['clientId'];
                      }
                      if (data['description'] != null) {
                        descriptionController.text = data['description'];
                      }
                      if (data['products'] != null) {
                        final List<dynamic> productsJson = data['products'];
                        products.value = productsJson
                            .map(
                              (e) =>
                                  Product.fromJson(e as Map<String, dynamic>),
                            )
                            .toList();
                      }
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.draftRestored)),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.error(e.toString())),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            );
          }
        });
      }
      return null;
    }, []);

    // Save draft listener
    useEffect(
      () {
        if (deal == null) {
          final timer = Timer.periodic(const Duration(seconds: 5), (_) {
            final data = {
              'clientId': selectedClientId.value,
              'description': descriptionController.text,
              'products': products.value.map((e) => e.toJson()).toList(),
            };
            getIt<DraftService>().saveDraft('new_deal', data);
          });
          return timer.cancel;
        }
        return null;
      },
      [selectedClientId.value, descriptionController],
    ); // Simplified dependencies

    final total = products.value.fold(0.0, (sum, p) => sum + p.total);

    void showProductDialog([Product? productToEdit]) {
      showDialog(
        context: context,
        builder: (context) => _ProductDialog(
          product: productToEdit,
          onSave: (product) {
            if (productToEdit != null) {
              products.value = products.value
                  .map((p) => p.id == product.id ? product : p)
                  .toList();
            } else {
              products.value = [...products.value, product];
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(deal == null ? l10n.newDeal : l10n.editDeal)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Client Selection
                clientsAsync.when(
                  data: (clients) {
                    final clientExists =
                        selectedClientId.value != null &&
                        clients.any((c) => c.id == selectedClientId.value);

                    return DropdownButtonFormField<String>(
                      value: clientExists ? selectedClientId.value : null,
                      decoration: InputDecoration(labelText: l10n.client),
                      items: clients
                          .map(
                            (c) => DropdownMenuItem(
                              value: c.id,
                              child: Text(c.name),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => selectedClientId.value = val,
                      validator: (value) =>
                          value == null ? l10n.fieldRequired : null,
                    );
                  },
                  loading: () => const LinearProgressIndicator(),
                  error: (e, _) => Text(l10n.errorLoadingClients(e.toString())),
                ),
                const Gap(16),

                // Status
                DropdownButtonFormField<DealStatus>(
                  initialValue: status.value,
                  decoration: InputDecoration(labelText: l10n.dealStatus),
                  items: DealStatus.values
                      .map(
                        (s) => DropdownMenuItem(value: s, child: Text(s.label)),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) status.value = val;
                  },
                ),
                const Gap(16),

                // Description (Notes) with Voice Input
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: l10n.notes,
                    suffixIcon: _VoiceInputSuffix(
                      controller: descriptionController,
                    ),
                  ),
                  maxLines: 3,
                ),
                const Gap(16),

                // Products
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.dealProducts,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        if (deal != null)
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    _DealHistorySheet(dealId: deal!.id),
                              );
                            },
                            icon: const Icon(Icons.history),
                            tooltip: l10n.history,
                          ),
                        IconButton(
                          onPressed: () => showProductDialog(),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
                ...products.value.map(
                  (p) => ListTile(
                    leading: p.photoPath != null
                        ? Image.file(
                            File(p.photoPath!),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.image),
                          ),
                    title: Text(p.name),
                    subtitle: Text('${p.quantity} x ${p.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${p.total}'),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => showProductDialog(p),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),

                          onPressed: () {
                            products.value = products.value
                                .where((e) => e.id != p.id)
                                .toList();
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(16),
                Text(
                  l10n.total(currencyFormat.format(total)),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Gap(32),
                ElevatedButton(
                  onPressed: !canEdit
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            final newDeal = Deal(
                              id: deal?.id ?? const Uuid().v4(),
                              clientId: selectedClientId.value!,
                              products: products.value,
                              status: status.value,
                              createdAt: deal?.createdAt ?? DateTime.now(),
                              totalAmount: total,
                              paymentDate: status.value.isSuccessful
                                  ? (deal?.paymentDate ?? DateTime.now())
                                  : null,
                              description: descriptionController.text,
                              authorId:
                                  deal?.authorId ??
                                  getIt<AuthService>().currentUserId,
                            );

                            if (deal == null) {
                              ref.read(dealsProvider.notifier).addDeal(newDeal);
                              getIt<DraftService>().clearDraft('new_deal');
                            } else {
                              ref
                                  .read(dealsProvider.notifier)
                                  .updateDeal(newDeal);
                            }
                            context.router.back();
                          }
                        },
                  child: Text(l10n.saveDeal),
                ),
                if (deal != null) ...[
                  const Gap(32),
                  Text(
                    l10n.documents,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.picture_as_pdf),
                          label: Text(l10n.quote),
                          onPressed: () async {
                            final client = clientsAsync.value?.firstWhere(
                              (c) => c.id == deal!.clientId,
                            );
                            if (client == null) return;
                            final file = await getIt<PdfService>()
                                .generateQuote(deal!, client);
                            if (context.mounted) {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => SafeArea(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.open_in_new),
                                        title: Text(l10n.openFile),
                                        onTap: () {
                                          Navigator.pop(context);
                                          OpenFile.open(file.path);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.share),
                                        title: Text(l10n.shareFile),
                                        onTap: () {
                                          Navigator.pop(context);
                                          Share.shareXFiles([
                                            XFile(file.path),
                                          ], text: l10n.quoteFor(deal!.title));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.description),
                          label: Text(l10n.contract),
                          onPressed: () async {
                            final client = clientsAsync.value?.firstWhere(
                              (c) => c.id == deal!.clientId,
                            );
                            if (client == null) return;

                            showDialog(
                              context: context,
                              builder: (context) => _SignContractDialog(
                                onSigned: (signature) async {
                                  final file = await getIt<PdfService>()
                                      .generateContract(
                                        deal!,
                                        client,
                                        signature: signature,
                                      );
                                  if (context.mounted) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => SafeArea(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                Icons.open_in_new,
                                              ),
                                              title: Text(l10n.openFile),
                                              onTap: () {
                                                Navigator.pop(context);
                                                OpenFile.open(file.path);
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.share),
                                              title: Text(l10n.shareFile),
                                              onTap: () {
                                                Navigator.pop(context);
                                                Share.shareXFiles(
                                                  [XFile(file.path)],
                                                  text: l10n.contractFor(
                                                    deal!.title,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VoiceInputSuffix extends HookWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onResult;

  const _VoiceInputSuffix({required this.controller, this.onResult});

  @override
  Widget build(BuildContext context) {
    final isListening = useState(false);
    final l10n = AppLocalizations.of(context)!;

    return IconButton(
      icon: Icon(
        isListening.value ? Icons.mic_off : Icons.mic,
        color: isListening.value ? Colors.red : null,
      ),
      onPressed: () async {
        final speech = getIt<SpeechService>();
        if (isListening.value) {
          await speech.stopListening();
          isListening.value = false;
        } else {
          isListening.value = true;
          await speech.startListening(
            onResult: (text) {
              if (onResult != null) {
                onResult!(text);
              } else {
                // If it's a numeric field (heuristic based on controller usage context,
                // but here we just have controller), we might want to clean it?
                // For now, raw text.
                controller.text = text;
              }
            },
            onDone: () {
              isListening.value = false;
            },
            onError: (error) {
              isListening.value = false;
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${l10n.error(error)}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}

class _DealHistorySheet extends HookConsumerWidget {
  final String dealId;

  const _DealHistorySheet({required this.dealId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.historyOfChanges,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(16),
          Expanded(
            child: FutureBuilder(
              future: getIt<DealsRepository>().getHistory(dealId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(l10n.error(snapshot.error.toString())),
                  );
                }
                final history = snapshot.data as List<DealHistory>;
                if (history.isEmpty) {
                  return Center(child: Text(l10n.noHistoryFound));
                }
                return ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final item = history[index];
                    return ListTile(
                      title: Text(
                        '${item.oldStatus.label} -> ${item.newStatus.label}',
                      ),
                      subtitle: Text(
                        '${DateFormat.yMMMd().add_jm().format(item.date)}\n${item.comment ?? ''}',
                      ),
                      isThreeLine: true,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductDialog extends HookWidget {
  final Function(Product) onSave;
  final Product? product;

  const _ProductDialog({required this.onSave, this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final nameController = useTextEditingController(text: product?.name);
    final descriptionController = useTextEditingController(
      text: product?.description,
    );
    final priceController = useTextEditingController(
      text: product?.price.toString(),
    );
    final costPriceController = useTextEditingController(
      text: product?.costPrice.toString() ?? '0',
    );
    final discountController = useTextEditingController(
      text: product?.discount.toString() ?? '0',
    );
    final taxController = useTextEditingController(
      text: product?.tax.toString() ?? '0',
    );
    final qtyController = useTextEditingController(
      text: product?.quantity.toString() ?? '1',
    );
    final photoPath = useState<String?>(product?.photoPath);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return AlertDialog(
      title: Text(product == null ? l10n.addProduct : l10n.editProduct),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    photoPath.value = image.path;
                  }
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: photoPath.value != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(photoPath.value!),
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(Icons.add_a_photo, size: 40),
                ),
              ),
              const Gap(16),
              TextFormField(
                controller: nameController,
                validator: (v) =>
                    v == null || v.isEmpty ? l10n.fieldRequired : null,
                decoration: InputDecoration(
                  labelText: l10n.productName,
                  suffixIcon: _VoiceInputSuffix(controller: nameController),
                ),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: l10n.description),
                maxLines: 2,
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: l10n.price),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty
                    ? l10n.fieldRequired
                    : (double.tryParse(v) == null ? l10n.invalidNumber : null),
              ),
              TextFormField(
                controller: costPriceController,
                decoration: InputDecoration(labelText: l10n.costPrice),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: discountController,
                decoration: InputDecoration(labelText: '${l10n.discount} (%)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: taxController,
                decoration: InputDecoration(labelText: l10n.tax),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: qtyController,
                decoration: InputDecoration(labelText: l10n.quantity),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final newProduct = Product(
                id: product?.id ?? const Uuid().v4(),
                name: nameController.text,
                description: descriptionController.text,
                price: double.tryParse(priceController.text) ?? 0,
                costPrice: double.tryParse(costPriceController.text) ?? 0,
                discount: double.tryParse(discountController.text) ?? 0,
                tax: double.tryParse(taxController.text) ?? 0,
                quantity: int.tryParse(qtyController.text) ?? 1,
                photoPath: photoPath.value,
              );
              onSave(newProduct);
              Navigator.pop(context);
            }
          },
          child: Text(product == null ? l10n.add : l10n.save),
        ),
      ],
    );
  }
}

class _SignContractDialog extends HookWidget {
  final Function(Uint8List) onSigned;

  const _SignContractDialog({required this.onSigned});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = useMemoized(
      () => SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.transparent,
      ),
    );

    return AlertDialog(
      title: Text(l10n.signContract),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Signature(
              controller: controller,
              height: 200,
              backgroundColor: Colors.white,
            ),
          ),
          const Gap(8),
          TextButton(
            onPressed: () => controller.clear(),
            child: Text(l10n.clear),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            if (controller.isNotEmpty) {
              final bytes = await controller.toPngBytes();
              if (bytes != null) {
                onSigned(bytes);
                Navigator.pop(context);
              }
            }
          },
          child: Text(l10n.signAndGenerate),
        ),
      ],
    );
  }
}
