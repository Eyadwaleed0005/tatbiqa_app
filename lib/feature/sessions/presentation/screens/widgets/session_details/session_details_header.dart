
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';

class SessionDetailsHeaderWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: ColorPalette.bgInteractive,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: BorderSide(color: ColorPalette.borderColor),
            ),
          ),
          icon: Icon(
            Icons.arrow_back,
            color: ColorPalette.primary,
            size: 20.sp,
          ),
        ),
        Text("تفاصيل السيشن", style: AppTextStyle.fontCairo18BoldWhiteColor),
        horizontalSpace(40),
      ],
    );
  }
}
