import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/feature/reports/domain/entity/reports_entity.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/custom_grid_item_widget.dart';

class CustomGridView extends StatelessWidget {
  const new({super.key, required this.report});

  final ReportsEntity? report;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10.w,
      mainAxisSpacing: 10.h,
      childAspectRatio: 1.5,
      children: [
        CustomGridItemWidget(
          title: "إجمالي الدخل",
          value: "${report?.totalIncome.toStringAsFixed(0) ?? '0'} ج.م",
          valueStyle: AppTextStyle.fontCairo32BoldPrimaryColor,
        ),
        CustomGridItemWidget(
          title: "دخل البلايستيشن",
          value: "${report?.playstationIncome.toStringAsFixed(0) ?? '0'} ج.م",
          valueStyle: AppTextStyle.fontCairo32BoldAmberColor,
        ),
        CustomGridItemWidget(
          title: "دخل المنتجات",
          value: "${report?.productsIncome.toStringAsFixed(0) ?? '0'} ج.م",
          valueStyle: AppTextStyle.fontCairo32BoldPrimaryColor,
        ),
        CustomGridItemWidget(
          title: "عدد السيشنات",
          value: "${report?.totalSessionsCount ?? 0}",
          valueStyle: AppTextStyle.fontCairo32BoldAmberColor,
        ),
      ],
    );
  }
}
