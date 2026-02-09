// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interactions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clientInteractionsHash() =>
    r'cc7c737c2f66c3176f6a974eb6460bc47f605432';

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

abstract class _$ClientInteractions
    extends BuildlessAutoDisposeAsyncNotifier<List<Interaction>> {
  late final String clientId;

  FutureOr<List<Interaction>> build(
    String clientId,
  );
}

/// See also [ClientInteractions].
@ProviderFor(ClientInteractions)
const clientInteractionsProvider = ClientInteractionsFamily();

/// See also [ClientInteractions].
class ClientInteractionsFamily extends Family<AsyncValue<List<Interaction>>> {
  /// See also [ClientInteractions].
  const ClientInteractionsFamily();

  /// See also [ClientInteractions].
  ClientInteractionsProvider call(
    String clientId,
  ) {
    return ClientInteractionsProvider(
      clientId,
    );
  }

  @override
  ClientInteractionsProvider getProviderOverride(
    covariant ClientInteractionsProvider provider,
  ) {
    return call(
      provider.clientId,
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
  String? get name => r'clientInteractionsProvider';
}

/// See also [ClientInteractions].
class ClientInteractionsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ClientInteractions, List<Interaction>> {
  /// See also [ClientInteractions].
  ClientInteractionsProvider(
    String clientId,
  ) : this._internal(
          () => ClientInteractions()..clientId = clientId,
          from: clientInteractionsProvider,
          name: r'clientInteractionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clientInteractionsHash,
          dependencies: ClientInteractionsFamily._dependencies,
          allTransitiveDependencies:
              ClientInteractionsFamily._allTransitiveDependencies,
          clientId: clientId,
        );

  ClientInteractionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.clientId,
  }) : super.internal();

  final String clientId;

  @override
  FutureOr<List<Interaction>> runNotifierBuild(
    covariant ClientInteractions notifier,
  ) {
    return notifier.build(
      clientId,
    );
  }

  @override
  Override overrideWith(ClientInteractions Function() create) {
    return ProviderOverride(
      origin: this,
      override: ClientInteractionsProvider._internal(
        () => create()..clientId = clientId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        clientId: clientId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ClientInteractions, List<Interaction>>
      createElement() {
    return _ClientInteractionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClientInteractionsProvider && other.clientId == clientId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, clientId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ClientInteractionsRef
    on AutoDisposeAsyncNotifierProviderRef<List<Interaction>> {
  /// The parameter `clientId` of this provider.
  String get clientId;
}

class _ClientInteractionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ClientInteractions,
        List<Interaction>> with ClientInteractionsRef {
  _ClientInteractionsProviderElement(super.provider);

  @override
  String get clientId => (origin as ClientInteractionsProvider).clientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
