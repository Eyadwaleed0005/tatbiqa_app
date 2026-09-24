
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tatbiqa/core/helper/formated_timer_text.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';

class CountdownTimerWidget extends StatefulWidget {
  final Duration remainingDuration;
  final VoidCallback? onTimerFinished;

  const CountdownTimerWidget({
    super.key,
    required this.remainingDuration,
    this.onTimerFinished,
  });

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late Timer _timer;
  late Duration _currentDuration;

  @override
  void initState() {
    super.initState();
    _currentDuration = widget.remainingDuration;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        if (_currentDuration.inSeconds > 0) {
          _currentDuration = _currentDuration - const Duration(seconds: 1);
        } else {
          _timer.cancel();
          if (widget.onTimerFinished != null) {
            widget.onTimerFinished!();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      backgroundColor: ColorPalette.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "وقت اللعب ",
              style: AppTextStyle.fontReadexPro10RegularGrayColor,
            ),
          ),
          verticalSpace(8),
          FormattedTimerText(duration: _currentDuration),
        ],
      ),
    );
  }
}
