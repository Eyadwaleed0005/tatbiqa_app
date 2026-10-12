import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';

class CustomEmptyState extends StatelessWidget {
  const CustomEmptyState({
    super.key,
    this.icon,
    required this.title,
    this.description,
    this.actionButton,
  });

  final Widget? icon;
  final String title; 
  final String? description; 
  final Widget? actionButton; 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              verticalSpace(24),
            ],

            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyle.fontCairoPlay24BoldWhiteColor
            ),

            if (description != null) ...[
              verticalSpace(8),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: AppTextStyle.fontReadexPro14RegularGrayColor
              ),
            ],

            if (actionButton != null) ...[
              verticalSpace(24),
              actionButton!,
            ],
          ],
        ),
      ),
    );
  }
}