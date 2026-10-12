import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';

class CustomTabsWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final List<String> tabTitles;

  const CustomTabsWidget({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
    this.tabTitles = const ["يومي", "شهري"],
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(tabTitles.length, (index) {
        final isSelected = selectedIndex == index;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0.w : 4.w,
              right: index == tabTitles.length - 1 ? 0.w : 4.w,
            ),
            child: GestureDetector(
              onTap: () => onTabChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorPalette.primary
                      : ColorPalette.secondary,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected
                        ? ColorPalette.primary
                        : ColorPalette.borderColor,
                  ),
                ),
                child: Text(
                  tabTitles[index],
                  style: isSelected
                      ? AppTextStyle.fontReadexPro14MediumBlackColor
                      : AppTextStyle.fontReadexPro14MediumWhiteColor,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
