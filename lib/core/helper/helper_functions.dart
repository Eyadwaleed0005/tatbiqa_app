import 'package:flutter/material.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';

class HelperFunctions {
  static void handleSessionAction(bool isBusy, BuildContext context) {
    if (isBusy) {
      Navigator.pushNamed(context, RouteNames.sessionDetails);

    } else {
      Navigator.pushNamed(context, RouteNames.startSession);
    }
  }
}
