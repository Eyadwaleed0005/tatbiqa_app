import 'package:flutter/material.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';

class HelperFunctions {
  static Future<void> handleFirstButtonAction(
    bool isBusy,
    BuildContext context,
    RoomEntity room,
  ) async {
    if (isBusy) {
      Navigator.pushNamed(context, RouteNames.addDrinksToSession);
    } else {
      await Navigator.pushNamed(
        context,
        RouteNames.roomSettings,
        arguments: room,
      );
    }
  }

  static void handleSecondButtonAction(bool isBusy, BuildContext context) {
    if (isBusy) {
      Navigator.pushNamed(context, RouteNames.sessionDetails);
    } else {
      Navigator.pushNamed(context, RouteNames.startSession);
    }
  }
}
