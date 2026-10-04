import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';

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

  static Future<void> handleSecondButtonAction(
    bool isBusy,
    BuildContext context,
    RoomEntity room,
    SessionEntity? session,
  ) async {
    if (isBusy) {
      Navigator.pushNamed(
        context,
        RouteNames.sessionDetails,
        arguments: session,
      );
    } else {
      await Navigator.pushNamed(
        context,
        RouteNames.startSession,
        arguments: room,
      );
    }
  }

  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  static String formatStartTime(DateTime startTime) {
    String formatted = DateFormat('hh:mm a').format(startTime);
    return formatted
        .replaceAll('PM', 'م ')
        .replaceAll('AM', 'ص ')
        .replaceAll('pm', 'م ')
        .replaceAll('am', 'ص ');
  }

  static double calculatePlayCost(SessionEntity session) {
    final minutes = DateTime.now().difference(session.startTime).inMinutes;
    return minutes * session.hourlyRate / 60.0;
  }

  static double calculateCurrentTotal(SessionEntity session) {
    return calculatePlayCost(session) + session.productsCost;
  }
}
