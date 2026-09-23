import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/style/app_color.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;

  const CustomCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: backgroundColor ?? ColorPalette.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r), 
        side: BorderSide(
          color: borderColor ?? ColorPalette.borderColor,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 28.h,
          bottom: 28.h,
          left: 24.w,
          right: 24.w,
        ),
        child: child,
      ),
    );
  }
}