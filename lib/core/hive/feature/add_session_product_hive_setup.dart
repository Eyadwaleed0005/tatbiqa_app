import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/feature/sessions/data/model/session_product_model.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';

abstract class AddSessionProductHiveSetup {
  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(SessionProductModelAdapter());
    }

    if (!Hive.isBoxOpen(HiveBoxes.sessionProducts)) {
      await Hive.openBox<SessionProductEntity>(HiveBoxes.sessionProducts);
    }
  }
}
