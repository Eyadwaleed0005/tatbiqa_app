import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/widgets/empty_or_error_state.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/dashboard_widgets/dashboard_header.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, this.header});

  final String message;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             header?? DashboardHeader(isCentered: true),
            verticalSpace(30),
            Expanded(
              child: EmptyOrErrorState(
                title: 'حدث خطأ ما حاول مرة اخري',
                description: message,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
