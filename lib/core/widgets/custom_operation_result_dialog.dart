import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_animations.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_outlined_button.dart';

enum CustomOperationResultType { success, failure }

class CustomOperationResultDialog extends StatelessWidget {
  const CustomOperationResultDialog({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    required this.actionText,
    this.secondaryActionText,
    this.onActionPressed,
    this.onSecondaryActionPressed,
    this.successIcon = Icons.check_circle_outline_rounded,
    this.failureIcon = Icons.error_outline_rounded,
  });

  final CustomOperationResultType type;
  final String title;
  final String message;
  final String actionText;
  final String? secondaryActionText;
  final VoidCallback? onActionPressed;
  final VoidCallback? onSecondaryActionPressed;
  final IconData successIcon;
  final IconData failureIcon;

  bool get isSuccess => type == CustomOperationResultType.success;

  bool get hasSecondaryAction =>
      secondaryActionText != null && secondaryActionText!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final statusColor = isSuccess ? ColorPalette.success : ColorPalette.error;
    final icon = isSuccess ? successIcon : failureIcon;

    return AppAnimations.operationDialogEntrance(
      child: Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            decoration: BoxDecoration(
              color: ColorPalette.bgInteractive,
              borderRadius: BorderRadius.circular(28.r),

              boxShadow: [
                BoxShadow(
                  color: statusColor.withValues(alpha: 0.12),
                  blurRadius: 28.r,
                  offset: Offset(0, 10.h),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, size: 38.sp, color: statusColor),
                ),
                verticalSpace(22),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.fontCairo18SemiBoldPrimaryColor,
                ),
                verticalSpace(10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: AppTextStyle.fontReadexPro14RegularGrayColor,
                ),
                verticalSpace(26),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: actionText,
                    onPressed:
                        onActionPressed ?? () => Navigator.of(context).pop(),
                  ),
                ),
                if (hasSecondaryAction) ...[
                  verticalSpace(12),
                  CustomOutlinedButton(
                    text: secondaryActionText!,
                    onPressed:
                        onSecondaryActionPressed ??
                        () => Navigator.of(context).pop(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
