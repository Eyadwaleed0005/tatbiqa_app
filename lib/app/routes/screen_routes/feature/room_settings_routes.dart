
import 'package:flutter/material.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/feature/rooms/presentation/screens/room_settings_screen.dart';

abstract final class RoomSettingsRoutes {
  const RoomSettingsRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.roomSettings:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const RoomSettingsScreen();
          },
        );

      default:
        return null;
    }
  }
}
