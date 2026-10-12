import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/app_loading_indicator.dart'; 

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? borderColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool isLoading; 

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderColor,
    this.backgroundColor,
    this.textStyle,
    this.icon,
    this.isLoading = false, 
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? ColorPalette.bgInteractive,
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: 12.h,
          left: 16.w,
          right: 16.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        side: BorderSide(
          color: borderColor ?? ColorPalette.borderColor,
          width: 1.w,
        ),
      ),
      child: isLoading
          ? AppLoadingIndicator(
              color: textStyle?.color ?? ColorPalette.whiteColor,
              size: 20.sp,
              strokeWidth: 2,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                  horizontalSpace(8),
                ],
                Text(
                  text,
                  style: textStyle ?? AppTextStyle.fontReadexPro14MediumWhiteColor,
                ),
              ],
            ),
    );
  }
}