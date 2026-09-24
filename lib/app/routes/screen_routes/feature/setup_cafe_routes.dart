
import 'package:flutter/material.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/feature/cafe/presentation/screens/setup_cafe_screen.dart';

abstract final class SetupCafeRoutes {
  const SetupCafeRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.setupCafe:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const SetupCafeScreen();
          },
        );

      default:
        return null;
    }
  }
}
