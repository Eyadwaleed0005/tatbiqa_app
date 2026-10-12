import 'package:flutter/material.dart';
import 'package:tatbiqa/core/helper/formated_timer_text.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';

class CountdownTimerWidget extends StatelessWidget {
  final Duration duration;

  const CountdownTimerWidget({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomAppCard(
        backgroundColor: ColorPalette.secondary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "وقت اللعب",
              style: AppTextStyle.fontReadexPro10RegularGrayColor,
            ),
            verticalSpace(8),
            FormattedTimerText(duration: duration),
          ],
        ),
      ),
    );
  }
}
