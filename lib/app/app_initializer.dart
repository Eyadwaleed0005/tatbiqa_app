import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/app/dependency_injection/service_locator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatbiqa/core/hive/feature/cafe_hive_setup.dart';
import 'package:tatbiqa/core/hive/feature/rooms_hive_setup.dart';
import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/feature/cafe/data/models/cafe_model.dart';

abstract final class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations(const <DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    await ScreenUtil.ensureScreenSize();

    await hiveInitialize();
    setupServiceLocator();
  }

  static Future<void> hiveInitialize() async {
    await Hive.initFlutter();
    await CafeHiveSetup.init();
    await RoomsHiveSetup.init();
    await Hive.openBox<CafeModel>(HiveBoxes.cafe);
  }
}
