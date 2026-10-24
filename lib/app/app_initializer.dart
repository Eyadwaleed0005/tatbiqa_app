import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/app/dependency_injection/service_locator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tatbiqa/core/hive/feature/add_session_product_hive_setup.dart';
import 'package:tatbiqa/core/hive/feature/cafe_hive_setup.dart';
import 'package:tatbiqa/core/hive/feature/product_hive_setup.dart';
import 'package:tatbiqa/core/hive/feature/rooms_hive_setup.dart';
import 'package:tatbiqa/core/hive/feature/sessions_hive_setup.dart';
import 'package:tatbiqa/firebase_options.dart';

abstract final class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
    await ProductsHiveSetup.init();
    await SessionsHiveSetup.init();
    await AddSessionProductHiveSetup.init();
  }
}
