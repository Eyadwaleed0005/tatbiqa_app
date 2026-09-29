import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';

class DrinkTotalCard extends StatelessWidget {
  final int totalAmount;

  const DrinkTotalCard({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$totalAmount',
            style: AppTextStyle.fontCairo20SemiBoldAmberColor,
          ),
          Text(
            'الإجمالي المحدد · ج.م',
            style: AppTextStyle.fontReadexPro12RegularGrayColor,
          ),
        ],
      ),
    );
  }
}
