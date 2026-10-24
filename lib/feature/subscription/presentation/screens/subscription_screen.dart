import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tatbiqa/core/helper/app_system_ui.dart';
import 'package:tatbiqa/feature/subscription/presentation/cubit/subscription_state.dart';
import 'package:tatbiqa/feature/subscription/presentation/screens/widgets/subscription_screen_content.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final state = args is SubscriptionExpiredState ? args : null;

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: SubscriptionScreenContent(
          cafeName: state?.cafeName ?? '-',
          endDate: state?.endDate,
        ),
      ),
    );
  }
}