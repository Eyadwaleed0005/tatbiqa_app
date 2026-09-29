import 'package:flutter/material.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/session_details_screen.dart';

abstract final class SessionDetailsRoutes {
  const SessionDetailsRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.sessionDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return SessionDetailsScreen();
          },
        );

      default:
        return null;
    }
  }
}
