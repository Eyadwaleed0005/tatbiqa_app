import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_animations.dart';
import 'package:tatbiqa/feature/reports/presentation/cubit/reports_cubit.dart';
import 'package:tatbiqa/feature/reports/presentation/cubit/reports_state.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/archive_widgets/archive_header_section.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/custom_grid_view.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/custom_tabs_widget.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/dashboard_widgets/dashboard_header.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/error_view.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/room_performance_widget.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/room_summry_widget.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/total_play_time_widget.dart';

class ArchiveScreenContent extends StatefulWidget {
  const ArchiveScreenContent({super.key});

  @override
  State<ArchiveScreenContent> createState() => _ArchiveScreenContentState();
}

class _ArchiveScreenContentState extends State<ArchiveScreenContent> {
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ReportsCubit>().fetchDailyReport(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        if (state is ReportsError) {
          return ErrorView(
            message: state.message,
            header: ArchiveHeaderSection(
              currentTabIndex: _currentTabIndex,
              onDateSelected: (DateTime selectedDate) {},
            ),
          );
        }

        final report = (state is ReportsLoaded) ? state.report : null;

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            child: AppAnimations.screenSection(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ArchiveHeaderSection(
                    currentTabIndex: _currentTabIndex,
                    onDateSelected: (selectedDate) {
                      if (_currentTabIndex == 0) {
                        context.read<ReportsCubit>().fetchDailyReport(
                          selectedDate,
                        );
                      } else {
                        context.read<ReportsCubit>().fetchMonthlyReport(
                          selectedDate.year,
                          selectedDate.month,
                        );
                      }
                    },
                  ),
                  verticalSpace(18),

                  CustomTabsWidget(
                    tabTitles: ["أرشيف يومي", "أرشيف شهري"],
                    selectedIndex: _currentTabIndex,
                    onTabChanged: (index) {
                      setState(() {
                        _currentTabIndex = index;
                      });
                      if (index == 0) {
                        context.read<ReportsCubit>().fetchDailyReport(
                          DateTime.now(),
                        );
                      } else {
                        final now = DateTime.now();
                        context.read<ReportsCubit>().fetchMonthlyReport(
                          now.year,
                          now.month,
                        );
                      }
                    },
                  ),
                  verticalSpace(16),

                  CustomGridView(report: report),
                  verticalSpace(12),

                  TotalPlayTimeWidget(
                    title: "إجمالي وقت اللعب",
                    timeValue: "${report?.totalPlayMinutes ?? 0} دقيقة",
                  ),
                  verticalSpace(12),

                  RoomsSummaryWidget(
                    title: "ملخص الغرف",
                    summaries: [
                      "أكثر غرفة دخلًا: ${report?.topRoomByRevenue ?? 'لا توجد'}",
                      "أقل غرفة دخلًا: ${report?.leastRoomByRevenue ?? 'لا توجد'}",
                      "أكثر غرفة وقتًا: ${report?.topRoomByTime ?? 'لا توجد'}",
                      "أقل غرفة وقتًا: ${report?.leastRoomByTime ?? 'لا توجد'}",
                    ],
                  ),
                  verticalSpace(12),

                  RoomPerformanceWidget(rooms: report?.roomsPerformance ?? []),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
