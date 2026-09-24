import 'package:flutter/material.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';

class HelperFunctions {
  static void handleFirstButtonAction(bool isBusy, BuildContext context) {
    if (isBusy) {
    } else {
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