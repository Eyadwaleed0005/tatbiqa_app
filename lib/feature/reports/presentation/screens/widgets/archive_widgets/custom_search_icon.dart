import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/helper_functions.dart';
import 'package:tatbiqa/core/style/app_color.dart';

class CustomSearchIcon extends StatelessWidget {
  const CustomSearchIcon({
    super.key,
    required this.currentTabIndex,
    required this.onDateSelected,
  });

  final int currentTabIndex;
  final Function(DateTime selectedDate) onDateSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: ColorPalette.secondary,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorPalette.borderColor),
      ),
      child: IconButton(
        onPressed: () async {
          if (currentTabIndex == 0) {
            final DateTime? picked = await HelperFunctions.showDailyPicker(
              context,
            );
            if (picked != null) {
              onDateSelected(picked);
            }
          } else {
            HelperFunctions.showMonthYearPickerDialog(context, (
              selectedMonthDate,
            ) {
              onDateSelected(selectedMonthDate);
            });
          }
        },
        icon: Icon(Icons.search, color: ColorPalette.primary, size: 24.sp),
      ),
    );
  }
}
