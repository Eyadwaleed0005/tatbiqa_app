import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/core/widgets/custom_outlined_button.dart';
import 'package:tatbiqa/feature/subscription/presentation/screens/widgets/custom_status_icon.dart';

class SubscriptionScreenContent extends StatelessWidget {
  const SubscriptionScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomStatusIcon(
                  borderColor: ColorPalette.statusDanger,
                  icon: Icon(Icons.priority_high),
                ),
                verticalSpace(24),

                Text(
                  'انتهى الاشتراك',
                  style: AppTextStyle.fontCairo24BoldWhiteColor,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(8),

                Text(
                  'برجاء تجديد الاشتراك للاستمرار في استخدام التطبيق.',
                  style: AppTextStyle.fontReadexPro14RegularGrayColor,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(32),

                CustomAppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "اسم المحل : ELHAMOUL CITY ",
                        style: AppTextStyle.fontReadexPro14MediumWhiteColor,
                      ),

                      verticalSpace(20),
                      Text(
                        'تاريخ انتهاء الاشتراك : 18 سبتمبر 2026',
                        style: AppTextStyle.fontReadexPro14RegularGrayColor,
                      ),
                    ],
                  ),
                ),
                verticalSpace(24),

                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'تواصل للتجديد',
                    onPressed: () {},
                  ),
                ),
                verticalSpace(12),

                SizedBox(
                  width: double.infinity,
                  child: CustomOutlinedButton(
                    backgroundColor: ColorPalette.secondary,
                    text: 'إعادة المحاولة',
                    onPressed: () {},
                  ),
                ),
                verticalSpace(12),

                SizedBox(
                  width: double.infinity,
                  child: CustomOutlinedButton(
                    text: 'إدخال كود التفعيل',
                    backgroundColor: ColorPalette.secondary,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
