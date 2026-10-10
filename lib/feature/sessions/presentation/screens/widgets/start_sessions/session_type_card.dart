import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';

class SessionTypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SessionTypeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomAppCard(
        backgroundColor: ColorPalette.secondary,
        borderColor: isSelected
            ? ColorPalette.primary
            : ColorPalette.borderColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36.sp, color: ColorPalette.primary),
            verticalSpace(12),
            Text(title, style: AppTextStyle.fontCairo18SemiBoldWhiteColor),
          ],
        ),
      ),
    );
  }
}
