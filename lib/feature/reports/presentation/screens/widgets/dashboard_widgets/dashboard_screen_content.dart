import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_animations.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/feature/reports/presentation/cubit/dashboard_cubit.dart';
import 'package:tatbiqa/feature/reports/presentation/cubit/dashboard_state.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/dashboard_widgets/dashboard_header.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/dashboard_widgets/dashboard_tabs.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/dashboard_widgets/empty_view.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/dashboard_widgets/error_view.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/dashboard_widgets/loading_view.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/dashboard_widgets/stats_row.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/room_performance_widget.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/room_summry_widget.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/total_play_time_widget.dart';

class DashboardScreenContent extends StatefulWidget {
  const DashboardScreenContent({super.key});

  @override
  State<DashboardScreenContent> createState() => _DashboardScreenContentState();
}

class _DashboardScreenContentState extends State<DashboardScreenContent> {
  int _tabIndex = 0;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    final cubit = context.read<DashboardCubit>();
    final now = DateTime.now();
    _tabIndex == 0
        ? cubit.fetchDailyReport(now)
        : cubit.fetchMonthlyReport(now.year, now.month);
  }

  void _onTabChanged(int index) {
    setState(() => _tabIndex = index);
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return LoadingView(
              tabIndex: _tabIndex,
              onTabChanged: _onTabChanged,
            );
          }
          if (state is DashboardError) {
            return ErrorView(message: state.message);
          }
          if (state is DashboardLoaded) {
            final report = state.report;
            if (report.roomsPerformance.isEmpty) return const EmptyView();
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              child: AppAnimations.screenSection(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DashboardHeader(),
                    verticalSpace(16),
                    DashboardTabs(
                      selectedIndex: _tabIndex,
                      onTabChanged: _onTabChanged,
                    ),
                    verticalSpace(16),
                    StatsRow(
                      firstTitle: "إجمالي الدخل",
                      firstValue:
                          "${report.totalIncome.toStringAsFixed(0)} ج.م",
                      firstStyle: AppTextStyle.fontCairo32BoldPrimaryColor,
                      secondTitle: "دخل البلايستيشن",
                      secondValue:
                          "${report.playstationIncome.toStringAsFixed(0)} ج.م",
                      secondStyle: AppTextStyle.fontCairo32BoldAmberColor,
                    ),
                    verticalSpace(4),
                    StatsRow(
                      firstTitle: "دخل المنتجات",
                      firstValue:
                          "${report.productsIncome.toStringAsFixed(0)} ج.م",
                      firstStyle: AppTextStyle.fontCairo32BoldPrimaryColor,
                      secondTitle: "عدد السيشنات",
                      secondValue: "${report.totalSessionsCount}",
                      secondStyle: AppTextStyle.fontCairo32BoldAmberColor,
                    ),
                    verticalSpace(8),
                    TotalPlayTimeWidget(
                      title: "إجمالي وقت اللعب",
                      timeValue: "${report.totalPlayMinutes} دقيقة",
                    ),
                    verticalSpace(8),
                    RoomsSummaryWidget(
                      title: "ملخص الغرف",
                      summaries: [
                        "أكثر غرفة دخلًا: ${report.topRoomByRevenue ?? 'لا توجد بيانات'}",
                        "أقل غرفة دخلًا: ${report.leastRoomByRevenue ?? 'لا توجد بيانات'}",
                        "أكثر غرفة وقتًا: ${report.topRoomByTime ?? 'لا توجد بيانات'}",
                        "أقل غرفة وقتًا: ${report.leastRoomByTime ?? 'لا توجد بيانات'}",
                      ],
                    ),
                    verticalSpace(12),
                    RoomPerformanceWidget(rooms: report.roomsPerformance),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
