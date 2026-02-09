// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:crm_mobile/features/analytics/presentation/pages/analytics_page.dart'
    as _i1;
import 'package:crm_mobile/features/auth/presentation/pages/auth_page.dart'
    as _i2;
import 'package:crm_mobile/features/clients/domain/entities/client.dart'
    as _i12;
import 'package:crm_mobile/features/clients/presentation/pages/client_details_page.dart'
    as _i3;
import 'package:crm_mobile/features/clients/presentation/pages/client_form_page.dart'
    as _i4;
import 'package:crm_mobile/features/clients/presentation/pages/clients_page.dart'
    as _i5;
import 'package:crm_mobile/features/deals/domain/entities/deal.dart' as _i13;
import 'package:crm_mobile/features/deals/presentation/pages/deal_form_page.dart'
    as _i6;
import 'package:crm_mobile/features/deals/presentation/pages/deals_page.dart'
    as _i7;
import 'package:crm_mobile/features/home/presentation/pages/home_page.dart'
    as _i8;
import 'package:crm_mobile/features/settings/presentation/pages/settings_page.dart'
    as _i9;
import 'package:flutter/material.dart' as _i11;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    AnalyticsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AnalyticsPage(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AuthPage(),
      );
    },
    ClientDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ClientDetailsRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.ClientDetailsPage(
          key: args.key,
          client: args.client,
        ),
      );
    },
    ClientFormRoute.name: (routeData) {
      final args = routeData.argsAs<ClientFormRouteArgs>(
          orElse: () => const ClientFormRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.ClientFormPage(
          key: args.key,
          client: args.client,
        ),
      );
    },
    ClientsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ClientsPage(),
      );
    },
    DealFormRoute.name: (routeData) {
      final args = routeData.argsAs<DealFormRouteArgs>(
          orElse: () => const DealFormRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.DealFormPage(
          key: args.key,
          deal: args.deal,
          initialClientId: args.initialClientId,
        ),
      );
    },
    DealsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.DealsPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.HomePage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SettingsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AnalyticsPage]
class AnalyticsRoute extends _i10.PageRouteInfo<void> {
  const AnalyticsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AnalyticsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnalyticsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AuthPage]
class AuthRoute extends _i10.PageRouteInfo<void> {
  const AuthRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ClientDetailsPage]
class ClientDetailsRoute extends _i10.PageRouteInfo<ClientDetailsRouteArgs> {
  ClientDetailsRoute({
    _i11.Key? key,
    required _i12.Client client,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          ClientDetailsRoute.name,
          args: ClientDetailsRouteArgs(
            key: key,
            client: client,
          ),
          initialChildren: children,
        );

  static const String name = 'ClientDetailsRoute';

  static const _i10.PageInfo<ClientDetailsRouteArgs> page =
      _i10.PageInfo<ClientDetailsRouteArgs>(name);
}

class ClientDetailsRouteArgs {
  const ClientDetailsRouteArgs({
    this.key,
    required this.client,
  });

  final _i11.Key? key;

  final _i12.Client client;

  @override
  String toString() {
    return 'ClientDetailsRouteArgs{key: $key, client: $client}';
  }
}

/// generated route for
/// [_i4.ClientFormPage]
class ClientFormRoute extends _i10.PageRouteInfo<ClientFormRouteArgs> {
  ClientFormRoute({
    _i11.Key? key,
    _i12.Client? client,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          ClientFormRoute.name,
          args: ClientFormRouteArgs(
            key: key,
            client: client,
          ),
          initialChildren: children,
        );

  static const String name = 'ClientFormRoute';

  static const _i10.PageInfo<ClientFormRouteArgs> page =
      _i10.PageInfo<ClientFormRouteArgs>(name);
}

class ClientFormRouteArgs {
  const ClientFormRouteArgs({
    this.key,
    this.client,
  });

  final _i11.Key? key;

  final _i12.Client? client;

  @override
  String toString() {
    return 'ClientFormRouteArgs{key: $key, client: $client}';
  }
}

/// generated route for
/// [_i5.ClientsPage]
class ClientsRoute extends _i10.PageRouteInfo<void> {
  const ClientsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ClientsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClientsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.DealFormPage]
class DealFormRoute extends _i10.PageRouteInfo<DealFormRouteArgs> {
  DealFormRoute({
    _i11.Key? key,
    _i13.Deal? deal,
    String? initialClientId,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          DealFormRoute.name,
          args: DealFormRouteArgs(
            key: key,
            deal: deal,
            initialClientId: initialClientId,
          ),
          initialChildren: children,
        );

  static const String name = 'DealFormRoute';

  static const _i10.PageInfo<DealFormRouteArgs> page =
      _i10.PageInfo<DealFormRouteArgs>(name);
}

class DealFormRouteArgs {
  const DealFormRouteArgs({
    this.key,
    this.deal,
    this.initialClientId,
  });

  final _i11.Key? key;

  final _i13.Deal? deal;

  final String? initialClientId;

  @override
  String toString() {
    return 'DealFormRouteArgs{key: $key, deal: $deal, initialClientId: $initialClientId}';
  }
}

/// generated route for
/// [_i7.DealsPage]
class DealsRoute extends _i10.PageRouteInfo<void> {
  const DealsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          DealsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SettingsPage]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
