import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:crm_mobile/l10n/app_localizations.dart';
import '../../domain/entities/client.dart';
import '../providers/clients_provider.dart';

@RoutePage()
class ClientFormPage extends HookConsumerWidget {
  final Client? client;

  const ClientFormPage({super.key, this.client});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final nameController = useTextEditingController(text: client?.name);
    final phoneController = useTextEditingController(text: client?.phone);
    final emailController = useTextEditingController(text: client?.email);
    final addressController = useTextEditingController(text: client?.address);
    final commentController = useTextEditingController(text: client?.comment);

    return Scaffold(
      appBar: AppBar(
        title: Text(client == null ? l10n.newClient : l10n.editClient),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: l10n.clientName),
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: l10n.clientPhone),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: l10n.clientEmail),
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: l10n.clientAddress),
              ),
              TextFormField(
                controller: commentController,
                decoration: InputDecoration(labelText: l10n.clientComment),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final newClient = Client(
                    id: client?.id ?? const Uuid().v4(),
                    name: nameController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                    address: addressController.text,
                    comment: commentController.text,
                    createdAt: client?.createdAt ?? DateTime.now(),
                  );

                  if (client == null) {
                    ref.read(clientsProvider.notifier).addClient(newClient);
                  } else {
                    ref.read(clientsProvider.notifier).updateClient(newClient);
                  }
                  context.router.back();
                },
                child: Text(l10n.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
