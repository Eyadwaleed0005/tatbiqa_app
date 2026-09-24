
import 'package:flutter/material.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/start_seesions_screen.dart';

abstract final class StartSessionRoutes {
  const StartSessionRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.startSession:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return  StartSeesionScreen();
          },
        );

      default:
        return null;
    }
  }
}
