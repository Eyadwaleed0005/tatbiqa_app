import 'package:flutter/material.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';

class FormattedTimerText extends StatelessWidget {
  final Duration duration;

  const FormattedTimerText({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final baseStyle = AppTextStyle.fontCairo44BoldPrimaryColor;

    final separatorStyle = baseStyle.copyWith(color: ColorPalette.amber);

    if (hours > 0) {
      return RichText(
        text: TextSpan(
          style: baseStyle,
          children: [
            TextSpan(text: "$hours"),
            TextSpan(text: ":", style: separatorStyle),
            TextSpan(text: twoDigits(minutes)),
            TextSpan(text: ":", style: separatorStyle),
            TextSpan(text: twoDigits(seconds)),
          ],
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          style: baseStyle,
          children: [
            TextSpan(text: twoDigits(minutes)),
            TextSpan(text: ":", style: separatorStyle),
            TextSpan(text: twoDigits(seconds)),
          ],
        ),
      );
    }
  }
}
