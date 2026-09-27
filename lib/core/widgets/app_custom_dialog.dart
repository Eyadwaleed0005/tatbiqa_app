import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/core/widgets/custom_outlined_button.dart';

class AppCustomDialog extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final TextAlign titleTextAlign;
  final Widget contentChild;
  final String confirmButtonText;
  final VoidCallback onConfirm;
  final Color? confirmButtonColor;
  final TextStyle? confirmTextStyle;

  const AppCustomDialog({
    super.key,
    this.title,
    this.subtitle,
    this.titleTextAlign = TextAlign.center,
    required this.contentChild,
    required this.confirmButtonText,
    required this.onConfirm,
    this.confirmButtonColor,
    this.confirmTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      child: CustomAppCard(
        backgroundColor: ColorPalette.secondary,
        borderColor: ColorPalette.borderColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null && title!.isNotEmpty) ...[
              Text(
                title!,
                style: AppTextStyle.fontCairo24BoldWhiteColor,
                textAlign: titleTextAlign,
              ),
              verticalSpace(10),
            ],

            if (subtitle != null && subtitle!.isNotEmpty) ...[
              Text(
                subtitle!,
                style: AppTextStyle.fontReadexPro12RegularGrayColor,
                textAlign: TextAlign.end,
              ),
              verticalSpace(24),
            ],

            contentChild,
            verticalSpace(24),

            CustomElevatedButton(
              text: confirmButtonText,
              backgroundColor: confirmButtonColor ?? ColorPalette.primary,
              textStyle:
                  confirmTextStyle ??
                  AppTextStyle.fontReadexPro14MediumBlackColor,
              onPressed: onConfirm,
            ),
            verticalSpace(12),

            CustomOutlinedButton(
              text: 'إلغاء',
              backgroundColor: ColorPalette.secondary,
              borderColor: ColorPalette.borderColor,
              textStyle: AppTextStyle.fontReadexPro14MediumWhiteColor,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
