import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/feature/cafe/data/models/cafe_model.dart';

abstract class CafeHiveSetup {
  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CafeModelAdapter());
    }

    if (!Hive.isBoxOpen(HiveBoxes.cafe)) {
      await Hive.openBox<CafeModel>(HiveBoxes.cafe);
    }
  }
}