import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/app/dependency_injection/service_locator.dart';
import 'package:tatbiqa/core/helper/app_system_ui.dart';
import 'package:tatbiqa/core/widgets/custom_app_bar.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/sessions_cubit.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/start_sessions/start_sessions_content.dart';

class StartSeesionScreen extends StatelessWidget {
  final RoomEntity room;

  const StartSeesionScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: BlocProvider(
          create: (context) => getIt.get<SessionsCubit>(),
          child: StartSessionContent(room: room),
        ),
      ),
    );
  }
}
