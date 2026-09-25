
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/style/app_color.dart';

class SplashLoadingBar extends StatelessWidget {
  const SplashLoadingBar({
    super.key,
    this.duration = const Duration(seconds: 3),
    this.onCompleted,
  });

  final Duration duration;
  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: duration,
      curve: Curves.easeInOut,
      onEnd: onCompleted,
      builder: (context, progress, child) {
        return SizedBox(
          width: double.infinity,
          height: 6.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ColoredBox(
                    color: ColorPalette.bgInteractive,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: progress,
                    heightFactor: 1,
                    child: const ColoredBox(color: ColorPalette.primary),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}