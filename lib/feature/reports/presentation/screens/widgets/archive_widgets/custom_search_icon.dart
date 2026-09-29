
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/style/app_color.dart';

class CustomSearchIcon extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: ColorPalette.secondary,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorPalette.borderColor),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.search,
          color: ColorPalette.primary,
          size: 24.sp,
        ),
      ),
    );
  }
}
