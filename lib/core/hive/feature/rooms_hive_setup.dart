import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/feature/rooms/data/models/room_model.dart';

abstract class RoomsHiveSetup {
  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
Hive.registerAdapter(RoomModelAdapter());

    }

    if (!Hive.isBoxOpen(HiveBoxes.rooms)) {
      await Hive.openBox<RoomModel>(HiveBoxes.rooms);
    }
  }
}