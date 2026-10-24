import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/app/dependency_injection/service_locator.dart';
import 'package:tatbiqa/core/helper/app_system_ui.dart';
import 'package:tatbiqa/feature/cafe/presentation/cubit/cafe_cubit.dart';
import 'package:tatbiqa/feature/cafe/presentation/screens/widgets/setup_cafe_content.dart';
import 'package:tatbiqa/feature/subscription/presentation/cubit/subscription_cubit.dart';

class SetupCafeScreen extends StatelessWidget {
  const SetupCafeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<CafeCubit>()),
    BlocProvider(create: (_) => getIt.get<SubscriptionCubit>()),

          ],
          child: SetupCafeContent(),
        ),
      ),
    );
  }
}
