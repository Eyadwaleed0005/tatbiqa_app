import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/start_sessions/session_type_selection.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/start_sessions/start_session_header_section.dart';

class StartSessionContent extends StatelessWidget {
  const new({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StartSessionHeaderSection(),
            verticalSpace(16),
            CustomAppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "متاحة",
                            style:
                                AppTextStyle.fontReadexPro14MediumPrimaryColor,
                          ),
                          horizontalSpace(6),

                          Container(
                            width: 8.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: ColorPalette.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "غرفة 01",
                        style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
                      ),
                    ],
                  ),
                  verticalSpace(12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "سعر الساعة: 50 ج.م  •  جاهزة لبدء سيشن",
                      style: AppTextStyle.fontReadexPro14RegularGrayColor,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(24),
            SessionTypeSelection(),
            verticalSpace(200),
            Center(
              child: Text(
                "سيبدأ احتساب الوقت فور تأكيد بدء السيشن.",
                style: AppTextStyle.fontReadexPro14RegularGrayColor,
              ),
            ),
            verticalSpace(16),

            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(text: "بدء سيشن", onPressed: () {}),
            ),
            verticalSpace(16),
          ],
        ),
      ),
    );
  }
}
