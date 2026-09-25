import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/session_details/countdown_Timer_widget.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/session_details/session_action_section.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/session_details/session_details_header.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/session_details/session_details_header_card.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/session_details/summary_checkout_session_details_card.dart';

class SessionDetailsContent extends StatelessWidget {
  const SessionDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SessionDetailsHeaderWidget(),

            verticalSpace(12),
            SessionDetailsHeaderCard(),

            verticalSpace(12),

            CountdownTimerWidget(
              remainingDuration: const Duration(
                hours: 1,
                minutes: 12,
                seconds: 51,
              ),
              onTimerFinished: () {
                print("انتهى وقت السيشن!");
              },
            ),
            verticalSpace(12),

            SummaryCheckoutSessionDetailsCard(),

            verticalSpace(12),
            SessionActionsSection(),
          ],
        ),
      ),
    );
  }
}
