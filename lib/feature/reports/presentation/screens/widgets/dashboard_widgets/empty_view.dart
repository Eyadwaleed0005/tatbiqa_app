
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/widgets/empty_or_error_state.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/dashboard_widgets/dashboard_header.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          const DashboardHeader(isCentered: true),
          verticalSpace(30),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: const EmptyOrErrorState(
                title: 'لا يوجد تقارير',
                description: 'لم يتم العثور علي اي تقارير حاليا',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
