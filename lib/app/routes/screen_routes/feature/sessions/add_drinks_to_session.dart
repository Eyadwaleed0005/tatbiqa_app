import 'package:flutter/material.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/add_drinks_to_session.dart';

abstract final class AddDrinksToSessionRoutes {
  const AddDrinksToSessionRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.addDrinksToSession:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return AddDrinksToSessionScreen();
          },
        );

      default:
        return null;
    }
  }
}
