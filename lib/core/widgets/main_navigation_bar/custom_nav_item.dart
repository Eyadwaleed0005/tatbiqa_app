
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tatbiqa/core/style/app_color.dart';

class CustomNavItem extends StatelessWidget {
  final String iconPath;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavItem({
    super.key,
    required this.iconPath,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? ColorPalette.primary : ColorPalette.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: 
        
      SvgPicture.asset(
          iconPath,
          width: 24.sp,
          height: 24.sp,
          colorFilter: ColorFilter.mode(
            isSelected ? ColorPalette.blackColor : ColorPalette.gray,
            BlendMode.srcIn,
          ),
        ),
      ),
      
    );
  }
}
