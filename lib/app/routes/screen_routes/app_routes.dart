import 'package:flutter/material.dart';
import 'package:tatbiqa/app/routes/screen_routes/feature/app_startup_routes.dart';
import 'package:tatbiqa/app/routes/screen_routes/feature/main_navigation_routes.dart';
import 'package:tatbiqa/app/routes/screen_routes/feature/sessions/session_details_routes.dart';
import 'package:tatbiqa/app/routes/screen_routes/feature/sessions/start_session_routes.dart';
import 'package:tatbiqa/app/routes/screen_routes/feature/setup_cafe_routes.dart';

abstract final class AppRoutes {
  const AppRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    return AppStartupRoutes.generateRoute(settings) ??
        SetupCafeRoutes.generateRoute(settings) ??
        MainNavigationRoutes.generateRoute(settings) ??
        StartSessionRoutes.generateRoute(settings)??
        SessionDetailsRoutes.generateRoute(settings)??
        _buildUnknownRoute(settings);
  }

  static Route<dynamic> _buildUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) {
        return const Scaffold(
          body: Center(
            child: Text(
              'الصفحة المطلوبة غير موجودة',
              textDirection: TextDirection.rtl,
            ),
          ),
        );
      },
    );
  }
}
