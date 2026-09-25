import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tatbiqa/core/helper/app_system_ui.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/session_details/session_details_content.dart';

class SessionDetailsScreen extends StatelessWidget {
  const SessionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:AnnotatedRegion<SystemUiOverlayStyle>(value: AppSystemUi.dark(),
      child: SessionDetailsContent())
    );
  }
}

