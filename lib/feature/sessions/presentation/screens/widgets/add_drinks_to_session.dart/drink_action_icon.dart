import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/style/app_color.dart';

class DrinkActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isAvailable;
  const DrinkActionIcon({
    super.key,
    required this.icon,
    this.onTap,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          border: Border.all(color: ColorPalette.borderColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          color: isAvailable
              ? ColorPalette.primary
              : ColorPalette.primary.withValues(alpha: .6),
          size: 24.sp,
        ),
      ),
    );
  }
}
