import 'package:flutter/material.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/core/widgets/main_navigation_bar/main_navigation_bar.dart';

abstract final class MainNavigationRoutes {
  const MainNavigationRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.main:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const MainNavigationScreen();
          },
        );

      default:
        return null;
    }
  }
}
