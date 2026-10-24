import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/app/dependency_injection/service_locator.dart';
import 'package:tatbiqa/core/helper/app_system_ui.dart';
import 'package:tatbiqa/feature/app_startup/presentation/screens/widgets/splash_screen_content.dart';
import 'package:tatbiqa/feature/subscription/presentation/cubit/subscription_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: BlocProvider(
          create: (context) => getIt.get<SubscriptionCubit>(),
          child: SplashScreenContent(),
        ),
      ),
    );
  }
}
