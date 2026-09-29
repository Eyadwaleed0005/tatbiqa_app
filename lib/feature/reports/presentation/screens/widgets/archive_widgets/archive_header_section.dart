
import 'package:flutter/material.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/archive_widgets/custom_search_icon.dart';

class ArchiveHeaderSection extends StatelessWidget {
  const ArchiveHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomSearchIcon(),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "الارشيف",
            style: AppTextStyle.fontCairo24BoldWhiteColor,
          ),
        ),
      ],
    );
  }
}
