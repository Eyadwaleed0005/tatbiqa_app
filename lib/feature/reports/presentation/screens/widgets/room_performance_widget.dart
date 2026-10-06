import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';

class RoomPerformanceWidget extends StatelessWidget {
  final String roomName;
  final String sessionsCount;
  final String totalMinutes;
  final String playIncome;
  final String productsIncome;
  final String totalIncome;

  const RoomPerformanceWidget({
    super.key,
    required this.roomName,
    required this.sessionsCount,
    required this.totalMinutes,
    required this.playIncome,
    required this.productsIncome,
    required this.totalIncome,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              roomName,
              style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
              textAlign: TextAlign.right,
            ),
            verticalSpace(8),
            Text(
              "  سيشنات :$sessionsCount   $totalMinutes دقيقة  ·  لعب: $playIncome  ·  منتجات: $productsIncome  ·  الإجمالي: $totalIncome",
              style: AppTextStyle.fontReadexPro12RegularGrayColor,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
