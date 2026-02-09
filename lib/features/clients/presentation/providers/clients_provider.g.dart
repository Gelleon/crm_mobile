// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clients_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clientHash() => r'0259e442a196a4b5cd56744537d9b7ed92b5bf91';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [client].
@ProviderFor(client)
const clientProvider = ClientFamily();

/// See also [client].
class ClientFamily extends Family<Client?> {
  /// See also [client].
  const ClientFamily();

  /// See also [client].
  ClientProvider call(
    String id,
  ) {
    return ClientProvider(
      id,
    );
  }

  @override
  ClientProvider getProviderOverride(
    covariant ClientProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'clientProvider';
}

/// See also [client].
class ClientProvider extends AutoDisposeProvider<Client?> {
  /// See also [client].
  ClientProvider(
    String id,
  ) : this._internal(
          (ref) => client(
            ref as ClientRef,
            id,
          ),
          from: clientProvider,
          name: r'clientProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clientHash,
          dependencies: ClientFamily._dependencies,
          allTransitiveDependencies: ClientFamily._allTransitiveDependencies,
          id: id,
        );

  ClientProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Client? Function(ClientRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClientProvider._internal(
        (ref) => create(ref as ClientRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Client?> createElement() {
    return _ClientProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClientProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ClientRef on AutoDisposeProviderRef<Client?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ClientProviderElement extends AutoDisposeProviderElement<Client?>
    with ClientRef {
  _ClientProviderElement(super.provider);

  @override
  String get id => (origin as ClientProvider).id;
}

String _$clientsHash() => r'78812118e652a39be8b2baf5c15fe42f68c0e2e1';

/// See also [Clients].
@ProviderFor(Clients)
final clientsProvider =
    AutoDisposeAsyncNotifierProvider<Clients, List<Client>>.internal(
  Clients.new,
  name: r'clientsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$clientsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Clients = AutoDisposeAsyncNotifier<List<Client>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
