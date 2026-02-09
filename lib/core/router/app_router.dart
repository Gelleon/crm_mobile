import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthRoute.page, initial: true),
    AutoRoute(
      page: HomeRoute.page,
      children: [
        AutoRoute(page: ClientsRoute.page),
        AutoRoute(page: DealsRoute.page),
        AutoRoute(page: AnalyticsRoute.page),
      ],
    ),
    AutoRoute(page: ClientFormRoute.page),
    AutoRoute(page: DealFormRoute.page),
    AutoRoute(page: ClientDetailsRoute.page),
    AutoRoute(page: SettingsRoute.page),
  ];
}
