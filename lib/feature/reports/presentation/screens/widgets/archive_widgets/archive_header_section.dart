import 'package:flutter/material.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/archive_widgets/custom_search_icon.dart';

class ArchiveHeaderSection extends StatelessWidget {
  final int currentTabIndex; 
  final Function(DateTime selectedDate) onDateSelected; 

  const ArchiveHeaderSection({
    super.key,
    required this.currentTabIndex,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomSearchIcon(currentTabIndex: currentTabIndex, onDateSelected: onDateSelected,),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "الأرشيف",
            style: AppTextStyle.fontCairo24BoldWhiteColor,
          ),
        ),
      ],
    );
  }

}