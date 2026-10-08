import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/app/dependency_injection/service_locator.dart';
import 'package:tatbiqa/core/helper/app_system_ui.dart';

import 'package:tatbiqa/core/widgets/custom_app_bar.dart';
import 'package:tatbiqa/feature/cafe/presentation/cubit/cafe_cubit.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/rooms_cubit.dart';

import 'package:tatbiqa/feature/settings/presentation/screens/widgets/settings_screen_content.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<RoomsCubit>()),
            BlocProvider(create: (context) =>getIt.get<CafeCubit> ()..getCafeInfo()),

          ],
          child: SettingsScreenContent(),
        ),
      ),
    );
  }
}
