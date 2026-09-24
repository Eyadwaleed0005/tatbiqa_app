import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tatbiqa/core/helper/app_system_ui.dart';
import 'package:tatbiqa/feature/cafe/presentation/screens/widgets/setup_cafe_content.dart';

class SetupCafeScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.dark(),
      child: SetupCafeContent()) ,);


  }
}
