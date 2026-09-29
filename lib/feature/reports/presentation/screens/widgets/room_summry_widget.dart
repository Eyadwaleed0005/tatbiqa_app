
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';

class RoomsSummaryWidget extends StatelessWidget {
  final String title;
  final List<String> summaries;

  const RoomsSummaryWidget({
    super.key,
    required this.title,
    required this.summaries,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .end, 
          children: [
            Text(
              title,
              style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
              textAlign: TextAlign.right,
            ),
            verticalSpace(12),
            ...summaries.map(
              (text) => Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Text(
                  text,
                  style: AppTextStyle.fontReadexPro12RegularGrayColor,
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
