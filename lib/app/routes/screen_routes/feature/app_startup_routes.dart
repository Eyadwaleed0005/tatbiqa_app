import 'package:flutter/material.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/feature/app_startup/presentation/screens/splash_screen.dart';
import 'package:tatbiqa/feature/subscription/presentation/screens/subscription_screen.dart';

abstract final class AppStartupRoutes {
  const AppStartupRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const SubscriptionScreen();
          },
        );

      default:
        return null;
    }
  }
}
