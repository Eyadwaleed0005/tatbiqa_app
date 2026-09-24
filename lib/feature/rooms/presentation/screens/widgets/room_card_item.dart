import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/helper_functions.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/core/widgets/custom_outlined_button.dart';

class RoomCardItem extends StatelessWidget {
  final Map<String, dynamic> roomData;

  const RoomCardItem({super.key, required this.roomData});

  @override
  Widget build(BuildContext context) {
    final bool isBusy = roomData['isBusy'] ?? false;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomAppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isBusy
                          ? ColorPalette.statusDanger
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        roomData['status'],
                        style: isBusy
                            ? AppTextStyle.fontReadexPro12MediumDangerColor
                            : AppTextStyle.fontReadexPro14MediumPrimaryColor,
                      ),
                      horizontalSpace(6),

                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: isBusy
                              ? ColorPalette.statusDanger
                              : ColorPalette.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  roomData['name'],
                  style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
                ),
              ],
            ),
            verticalSpace(12),

            Text(
              'سعر الساعة: ${roomData['hourlyRate']}',
              style: AppTextStyle.fontReadexPro14RegularGrayColor,
            ),
            if (isBusy) ...[
              verticalSpace(4),
              Text(
                'بدأت: ${roomData['startTime']}',
                style: AppTextStyle.fontReadexPro14RegularGrayColor,
              ),
              verticalSpace(4),
              Text(
                'مدة السيشن الحالية: ${roomData['currentDuration']}',
                style: AppTextStyle.fontReadexPro14RegularGrayColor,
              ),
              verticalSpace(4),
              Text(
                'إجمالي السيشن الحالي: ${roomData['currentTotal']}',
                style: AppTextStyle.fontReadexPro14RegularGrayColor,
              ),
            ],
            verticalSpace(4),
            Text(
              'دخل الغرفة اليوم: ${roomData['todayIncome']}',
              style: AppTextStyle.fontReadexPro14RegularGrayColor,
            ),
            verticalSpace(4),
            Text(
              'عدد سيشنات اليوم: ${roomData['sessionsCount']}',
              style: AppTextStyle.fontReadexPro14RegularGrayColor,
            ),
            verticalSpace(16),

            Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    text: isBusy ? 'إضافة مشروبات' : 'الإعدادات',
                    onPressed: ()=> HelperFunctions.handleSessionAction(isBusy,context),
                    backgroundColor: ColorPalette.bgInteractive,
                    textStyle: AppTextStyle.fontReadexPro14MediumWhiteColor,
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: CustomElevatedButton(
                    text: isBusy ? 'عرض التفاصيل' : 'بدء سيشن',
                    onPressed:()=> HelperFunctions.handleSessionAction(isBusy,context),
                    backgroundColor: ColorPalette.primary,
                    textStyle: AppTextStyle.fontReadexPro14MediumBlackColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
