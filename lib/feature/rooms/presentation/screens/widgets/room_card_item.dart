import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/helper_functions.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/core/widgets/custom_outlined_button.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/rooms_cubit.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';

class RoomCardItem extends StatefulWidget {
  final RoomEntity room;
  final SessionEntity? activeSession;
  final Map<String, dynamic>? roomStats; 

  const RoomCardItem({
    super.key, 
    required this.room, 
    this.activeSession,
    this.roomStats,
  });

  @override
  State<RoomCardItem> createState() => _RoomCardItemState();
}

class _RoomCardItemState extends State<RoomCardItem> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.activeSession != null) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {}); 
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void didUpdateWidget(covariant RoomCardItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeSession != null) {
      if (_timer == null || !_timer!.isActive) {
        _startTimer();
      }
    } else {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isBusy = widget.activeSession != null;

    String startTimeStr = '--:--';
    String durationStr = '00:00:00';
    double currentTotal = 0.0;

    if (isBusy && widget.activeSession != null) {
      startTimeStr = HelperFunctions.formatStartTime(widget.activeSession!.startTime);
      
      Duration diff = DateTime.now().difference(widget.activeSession!.startTime);
      durationStr = HelperFunctions.formatDuration(diff);
      
      currentTotal = HelperFunctions.calculateCurrentTotal(widget.activeSession!);
    }

    final double roomRevenueToday = widget.roomStats?['revenue'] ?? 0.0;
    final int roomSessionsCountToday = widget.roomStats?['count'] ?? 0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomAppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isBusy ? ColorPalette.statusDanger : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isBusy ? 'مشغولة' : 'متاحة',
                        style: isBusy
                            ? AppTextStyle.fontReadexPro12MediumDangerColor
                            : AppTextStyle.fontReadexPro14MediumPrimaryColor,
                      ),
                      horizontalSpace(6),
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: isBusy ? ColorPalette.statusDanger : ColorPalette.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.room.name,
                  style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
                ),
              ],
            ),
            verticalSpace(12),

            Text(
              'سعر الساعة: ${widget.room.hourlyRate.toStringAsFixed(0)} ج.م',
              style: AppTextStyle.fontReadexPro14RegularGrayColor,
            ),

            if (isBusy) ...[
              verticalSpace(4),
              Text(
                'بدأت: $startTimeStr',
                style: AppTextStyle.fontReadexPro14RegularGrayColor,
              ),
              verticalSpace(4),
              Text(
                'مدة السيشن الحالية: $durationStr',
                style: AppTextStyle.fontReadexPro14RegularGrayColor,
              ),
              verticalSpace(4),
              Text(
                'إجمالي السيشن الحالي: ${currentTotal.toStringAsFixed(2)} ج.م',
                style: AppTextStyle.fontReadexPro14RegularGrayColor,
              ),
            ],

            verticalSpace(4),
            Text(
              'دخل الغرفة اليوم: ${roomRevenueToday.toStringAsFixed(2)} ج.م',
              style: AppTextStyle.fontReadexPro14RegularGrayColor,
            ),
            verticalSpace(4),
            Text(
              'عدد سيشنات اليوم: $roomSessionsCountToday',
              style: AppTextStyle.fontReadexPro14RegularGrayColor,
            ),
            verticalSpace(16),

            Row(
              children: [
                if (!isBusy)
                  Expanded(
                    child: CustomOutlinedButton(
                      text: 'الإعدادات',
                      onPressed: () async {
                        await HelperFunctions.handleFirstButtonAction(
                          isBusy,
                          context,
                          widget.room,
                        );
                        if (context.mounted) {
                          context.read<RoomsCubit>().getRooms();
                        }
                      },
                      backgroundColor: ColorPalette.bgInteractive,
                      textStyle: AppTextStyle.fontReadexPro14MediumWhiteColor,
                    ),
                  ),
                if (!isBusy) horizontalSpace(12),
                if (isBusy)
                  Expanded(
                    child: CustomOutlinedButton(
                      text: 'إضافة مشروبات',
                      onPressed: () async {
                        await HelperFunctions.handleFirstButtonAction(
                          isBusy,
                          context,
                          widget.room,
                        );
                        if (context.mounted) {
                          context.read<RoomsCubit>().getRooms();
                        }
                      },
                      backgroundColor: ColorPalette.bgInteractive,
                      textStyle: AppTextStyle.fontReadexPro14MediumWhiteColor,
                    ),
                  ),
                if (isBusy) horizontalSpace(12),
                Expanded(
                  child: CustomElevatedButton(
                    text: isBusy ? 'عرض التفاصيل' : 'بدء سيشن',
                    onPressed: () async {
                      await HelperFunctions.handleSecondButtonAction(
                        isBusy,
                        context,
                        widget.room,
                        widget.activeSession
                      );
                      if (context.mounted) {
                        context.read<RoomsCubit>().getRooms();
                      }
                    },
                    backgroundColor: ColorPalette.primary,
                    textStyle: AppTextStyle.fontReadexPro14MediumBlackColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}