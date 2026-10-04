import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/helper_functions.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_animations.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/session_details/countdown_Timer_widget.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/session_details/session_action_section.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/session_details/session_details_header.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/session_details/session_details_header_card.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/session_details/summary_checkout_session_details_card.dart';

class SessionDetailsContent extends StatefulWidget {
  final SessionEntity session;
  const SessionDetailsContent({super.key, required this.session});

  @override
  State<SessionDetailsContent> createState() => _SessionDetailsContentState();
}

class _SessionDetailsContentState extends State<SessionDetailsContent> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionDetails = widget.session;
    final elapsed = DateTime.now().difference(sessionDetails.startTime);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: AppAnimations.screenSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SessionDetailsHeaderWidget(),
              verticalSpace(12),
              SessionDetailsHeaderCard(
                roomName: sessionDetails.roomName,
                startTime: HelperFunctions.formatStartTime(
                  sessionDetails.startTime,
                ),
                hourlyRate: sessionDetails.hourlyRate,
              ),
              verticalSpace(12),
              CountdownTimerWidget(duration: elapsed),
              verticalSpace(12),
              SummaryCheckoutSessionDetailsCard(
                total: HelperFunctions.calculateCurrentTotal(sessionDetails),
                playCost: HelperFunctions.calculatePlayCost(sessionDetails),
                productsCost: sessionDetails.productsCost,
              ),
              verticalSpace(12),
              SessionActionsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
