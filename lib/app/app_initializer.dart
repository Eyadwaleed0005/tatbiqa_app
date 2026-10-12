import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/app/dependency_injection/service_locator.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  }
}
