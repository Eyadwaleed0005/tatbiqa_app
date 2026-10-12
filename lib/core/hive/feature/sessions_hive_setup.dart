import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/feature/sessions/data/model/session_model.dart';

abstract class SessionsHiveSetup {
  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(3)) {
Hive.registerAdapter(SessionModelAdapter());

    }

    if (!Hive.isBoxOpen(HiveBoxes.sessions)) {
      await Hive.openBox<SessionModel>(HiveBoxes.sessions);
    }
  }
}