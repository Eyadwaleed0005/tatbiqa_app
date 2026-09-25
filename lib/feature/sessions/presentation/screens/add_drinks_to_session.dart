import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tatbiqa/core/helper/app_system_ui.dart';
import 'package:tatbiqa/core/widgets/custom_app_bar.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/add_drinks_to_session.dart/add_drinks_to_session_content.dart';

class AddDrinksToSessionScreen extends StatelessWidget {
  const AddDrinksToSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:      const CustomAppbar(),
      body:AnnotatedRegion<SystemUiOverlayStyle>(value: AppSystemUi.dark(),
      child: AddDrinksToSessionContent())
    );
  }
}

