import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_animations.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/feature/reports/data/model/analytics_item_model.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/archive_widgets/archive_header_section.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/custom_analytics_grid.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/custom_tabs_widget.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/room_summry_widget.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/total_play_time_widget.dart';

class ArchiveScreenContent extends StatefulWidget {
  const ArchiveScreenContent({super.key});

  @override
  State<ArchiveScreenContent> createState() => _ArchiveScreenContent();
}

class _ArchiveScreenContent extends State<ArchiveScreenContent> {
  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<AnalyticsItemModel> statsList = [
      AnalyticsItemModel(
        title: "إجمالي الدخل",
        value: "١,٨٥٠ ج.م",
        valueStyle: AppTextStyle.fontCairo32BoldPrimaryColor,
      ),
      AnalyticsItemModel(
        title: "دخل البلايستيشن",
        value: "١,٤٠٠ ج.م",
        valueStyle: AppTextStyle.fontCairo32BoldAmberColor,
      ),
      AnalyticsItemModel(
        title: "دخل المنتجات",
        value: "٤٥٠ ج.م",
        valueStyle: AppTextStyle.fontCairo32BoldPrimaryColor,
      ),
      AnalyticsItemModel(
        title: "عدد السيشنات",
        value: "٢٨",
        valueStyle: AppTextStyle.fontCairo32BoldAmberColor,
      ),
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),

        child: AppAnimations.screenSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArchiveHeaderSection(),
              verticalSpace(18),

              CustomTabsWidget(
                tabTitles: ["ارشيف يومي", "ارشيف شهري"],
                selectedIndex: _currentTabIndex,
                onTabChanged: (index) {
                  setState(() {
                    _currentTabIndex = index;
                  });
                },
              ),
              verticalSpace(8),

              CustomAnalyticsGrid(items: statsList),
              verticalSpace(8),

              const TotalPlayTimeWidget(
                title: "إجمالي وقت اللعب",
                timeValue: "١,٤٢٠ دقيقة",
              ),
              verticalSpace(8),

              const RoomsSummaryWidget(
                title: "ملخص الغرف",
                summaries: [
                  "أكثر غرفة دخلًا: غرفة 02 — 820 ج.م",
                  "أقل غرفة دخلًا: غرفة 03 — 320 ج.م",
                  "أكثر غرفة وقتًا: غرفة 02 — 420 دقيقة",
                  "أقل غرفة وقتًا: غرفة 03 — 160 دقيقة",
                ],
              ),
              verticalSpace(8),

              // const RoomPerformanceWidget(
              //   roomName: "غرفة 01",
              //   sessionsCount: "8",
              //   totalMinutes: "360",
              //   playIncome: "500 لعب",
              //   productsIncome: "150 منتجات",
              //   totalIncome: "650 إجمالي",
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
