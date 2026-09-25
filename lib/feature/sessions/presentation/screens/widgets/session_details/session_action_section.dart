import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/session_details/end_session_dialoge.dart';

class SessionActionsSection extends StatelessWidget {
  const SessionActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorPalette.bgInteractive,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "0",
                      style: AppTextStyle.fontReadexPro10SemiBoldPrimaryColor,
                    ),
                  ),
                  horizontalSpace(8),
                  Text(
                    "طلبات السيشن",
                    style: AppTextStyle.fontCairo18BoldWhiteColor,
                  ),
                ],
              ),
              verticalSpace(8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "لا توجد طلبات بعد. أضف طلباً من الزر أدناه",
                  style: AppTextStyle.fontReadexPro14RegularGrayColor,
                ),
              ),
            ],
          ),
        ),

        verticalSpace(12),

        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                text: "إنهاء السيشن",
                icon: Icon(
                  Icons.power_settings_new,
                  color: ColorPalette.brownColor,
                  size: 18,
                ),
                backgroundColor: ColorPalette.statusDanger,
                textStyle: AppTextStyle.fontCairo18BoldBrownColor,
                onPressed: () => EndSessionDialog.show(context),
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: CustomElevatedButton(
                text: "إضافة مشروبات",
                icon: Icon(
                  Icons.add_circle_outline,
                  color: ColorPalette.primary,
                  size: 18,
                ),
                backgroundColor: ColorPalette.bgInteractive,
                textStyle: AppTextStyle.fontCairo18BoldPrimaryColor,
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.addDrinksToSession);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
