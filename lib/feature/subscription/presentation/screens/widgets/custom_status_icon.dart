
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/style/app_color.dart';

class CustomStatusIcon extends StatelessWidget {
  final Widget icon;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? size;
  final double? borderWidth;

  const CustomStatusIcon({
    super.key,
    required this.icon,
    this.borderColor,
    this.backgroundColor,
    this.size,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 72.w,
      height: size ?? 72.h,
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorPalette.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? ColorPalette.statusDanger,
          width: borderWidth ?? 1.5.w,
        ),
      ),
      child: Center(child: icon),
    );
  }
}
