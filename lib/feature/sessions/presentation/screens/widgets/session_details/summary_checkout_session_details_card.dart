import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';

class SummaryCheckoutSessionDetailsCard extends StatelessWidget {
  final double playCost;
  final double productsCost;

  final double total;
  const SummaryCheckoutSessionDetailsCard({
    super.key,
    required this.playCost,
    required this.productsCost,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "لحظي",
                style: AppTextStyle.fontReadexPro10RegularPrimaryColor,
              ),
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
                "${playCost.toStringAsFixed(2)} ج.م",
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
              Text(
                "ج ${productsCost.toStringAsFixed(2)} ",
                style: AppTextStyle.fontReadexPro14SemiBoldAmberColor,
              ),
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
              Expanded(
                child: Text(
                  " ج.م ${total.toStringAsFixed(2)}",
                  style: AppTextStyle.fontCairo24BoldPrimaryColor,
                ),
              ),
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
