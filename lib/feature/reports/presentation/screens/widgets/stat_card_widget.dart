import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';

class StatCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle valueStyle;

  const StatCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: AppTextStyle.fontReadexPro12RegularGrayColor,
            textAlign: TextAlign.right,
          ),
          verticalSpace(8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(value, style: valueStyle),
          ),
        ],
      ),
    );
  }
}