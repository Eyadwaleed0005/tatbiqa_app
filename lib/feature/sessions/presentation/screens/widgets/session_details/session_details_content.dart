import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/helper_functions.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_animations.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/session_product_cubit.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/session_product_state.dart';
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
    context.read<SessionProductCubit>().getSessionProducts(widget.session.id);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = widget.session;
    final elapsed = DateTime.now().difference(session.startTime);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: AppAnimations.screenSection(
          child: BlocBuilder<SessionProductCubit, SessionProductState>(
            builder: (context, state) {
              final orders = state is SessionProductSuccess
                  ? state.session
                  : <SessionProductEntity>[];

              final productsCost = orders.fold<double>(
                0,
                (sum, o) => sum + o.totalPrice,
              );
              final playCost = HelperFunctions.calculatePlayCost(session);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SessionDetailsHeaderWidget(),
                  verticalSpace(12),
                  SessionDetailsHeaderCard(
                    roomName: session.roomName,
                    startTime: HelperFunctions.formatStartTime(
                      session.startTime,
                    ),
                    hourlyRate: session.hourlyRate,
                  ),
                  verticalSpace(12),
                  CountdownTimerWidget(duration: elapsed),
                  verticalSpace(12),
                  SummaryCheckoutSessionDetailsCard(
                    playCost: playCost,
                    productsCost: productsCost,
                    total: playCost + productsCost,
                  ),
                  verticalSpace(12),
                  SessionActionsSection(session: session, orders: orders),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
