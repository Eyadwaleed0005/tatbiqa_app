import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/feature/products/data/models/products_model.dart';

abstract class ProductsHiveSetup {
  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(ProductsModelAdapter());
    }

    if (!Hive.isBoxOpen(HiveBoxes.products)) {
      await Hive.openBox<ProductsModel>(HiveBoxes.products);
    }
  }
}