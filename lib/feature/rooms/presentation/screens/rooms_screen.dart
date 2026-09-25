import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tatbiqa/core/helper/app_system_ui.dart';
import 'package:tatbiqa/core/widgets/custom_app_bar.dart';
import 'package:tatbiqa/feature/rooms/presentation/screens/widgets/rooms_screen_content.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body:AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: RoomsScreenContent()) ,
    );
  }
}

