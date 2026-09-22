
import 'package:flutter/material.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';

abstract final class AppStartupRoutes {
  const AppStartupRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const Placeholder();
          },
        );

      default:
        return null;
    }
  }
}
