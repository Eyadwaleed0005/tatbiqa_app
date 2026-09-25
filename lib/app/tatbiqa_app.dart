import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/app/routes/screen_routes/app_routes.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/core/services/device_preview_service.dart';

class TatbiqaApp extends StatelessWidget {
  const TatbiqaApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          locale: DevicePreviewService.locale(context),
          theme: ThemeData.dark(),
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: AppRoutes.generateRoute,
          builder: _buildApp,
        );
      },
    );
  }

  Widget _buildApp(BuildContext context, Widget? child) {
    final Widget previewedChild = DevicePreviewService.appBuilder(
      context,
      child,
    );
    return previewedChild;
  }
}
