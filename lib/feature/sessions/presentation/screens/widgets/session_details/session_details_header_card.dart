import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';

class SessionDetailsHeaderCard extends StatelessWidget {
  final String statusText;
  final IconData roomIcon;
  const SessionDetailsHeaderCard({
    super.key,

    this.statusText = "مباشر",
    this.roomIcon = Icons.sports_esports,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: ColorPalette.brownColor,
              border: Border.all(color: ColorPalette.statusDanger),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  statusText,
                  style: AppTextStyle.fontReadexPro10SemiBoldStatusColor,
                ),
                horizontalSpace(6),
                Container(
                  width: 6.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: ColorPalette.statusDanger,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text( "غرفة 02", style: AppTextStyle.fontCairo24BoldWhiteColor),
                  verticalSpace(4),
                  Text(
                    "بدأ 08:15 م  70 ج.م/ساعة",
                    style: AppTextStyle.fontCairo12SemiBoldGrayColor,
                  ),
                ],
              ),
              horizontalSpace(12),
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: ColorPalette.bgInteractive,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: ColorPalette.borderColor),
                ),
                child: Icon(roomIcon, color: ColorPalette.primary, size: 24.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
