import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';

class SummaryCheckoutSessionDetailsCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("لحظي", style: AppTextStyle.fontReadexPro10RegularGrayColor),
              Text(
                "ملخص الحساب",
                style: AppTextStyle.fontCairo18BoldWhiteColor,
              ),
            ],
          ),
          verticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "85.00 ج.م",
                style: AppTextStyle.fontReadexPro14SemiBoldWhiteColor,
              ),
              Text(
                "تكلفة اللعب",
                style: AppTextStyle.fontReadexPro14RegularGrayColor,
              ),
            ],
          ),
          verticalSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("0 ج", style: AppTextStyle.fontReadexPro14SemiBoldAmberColor),
              Text(
                "الطلبات والمشروبات",
                style: AppTextStyle.fontReadexPro14RegularGrayColor,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Divider(color: ColorPalette.borderColor, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("ج.م85", style: AppTextStyle.fontCairo28BoldPrimaryColor),
              Text(
                "الإجمالي الحالي",
                style: AppTextStyle.fontCairo18BoldWhiteColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
