
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/feature/reports/data/model/analytics_item_model.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/custom_grid_item_widget.dart';

class CustomAnalyticsGrid extends StatelessWidget {
  final List<AnalyticsItemModel> items;

  const CustomAnalyticsGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2.w,
        mainAxisSpacing: 2.h,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return CustomGridItemWidget(
          title: item.title,
          value: item.value,
          valueStyle: item.valueStyle,
        );
      },
    );
  }
}
