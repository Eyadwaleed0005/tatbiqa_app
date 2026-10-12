import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/rooms_cubit.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';

class HelperFunctions {
  static Future<void> handleFirstButtonAction(
    bool isBusy,
    BuildContext context,
    RoomEntity room, [
    SessionEntity? session,
  ]) async {
    if (isBusy) {
      if (session == null) return;
      await Navigator.pushNamed(
        context,
        RouteNames.addDrinksToSession,
        arguments: session,
      );
    } else {
      await Navigator.pushNamed(
        context,
        RouteNames.roomSettings,
        arguments: room,
      );
    }
  }

static Future<void> handleSecondButtonAction(
  bool isBusy,
  BuildContext context,
  RoomEntity room,
  SessionEntity? session,
) async {
  if (isBusy) {
    await Navigator.pushNamed(
      context,
      RouteNames.sessionDetails,
      arguments: session,
    );
    if (context.mounted) {
      context.read<RoomsCubit>().getRooms();
    }
  } else {
    await Navigator.pushNamed(
      context,
      RouteNames.startSession,
      arguments: room,
    );
  }
}
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  static String formatStartTime(DateTime startTime) {
    String formatted = DateFormat('hh:mm a').format(startTime);
    return formatted
        .replaceAll('PM', 'م ')
        .replaceAll('AM', 'ص ')
        .replaceAll('pm', 'م ')
        .replaceAll('am', 'ص ');
  }

  static double calculatePlayCost(SessionEntity session) {
    final minutes = DateTime.now().difference(session.startTime).inMinutes;
    return minutes * session.hourlyRate / 60.0;
  }

  static double calculateCurrentTotal(SessionEntity session) {
    return calculatePlayCost(session) + session.productsCost;
  }

  static void showMonthYearPickerDialog(
    BuildContext context,
    Function(DateTime selectedDate) onMonthSelected,
  ) {
    int selectedYear = DateTime.now().year;
    int selectedMonth = DateTime.now().month;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: ColorPalette.secondary,
              title: Text(
                "اختر الشهر والسنة",
                style: TextStyle(color: ColorPalette.whiteColor, fontSize: 18.sp),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: 300.w,
                height: 150.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<int>(
                      value: selectedYear,
                      dropdownColor: ColorPalette.secondary,
                      style: const TextStyle(color: ColorPalette.whiteColor, ),
                      items: List.generate(30, (index) => 2023 + index).map((
                        year,
                      ) {
                        return DropdownMenuItem(
                          value: year,
                          child: Text("سنة $year"),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setStateDialog(() {
                            selectedYear = val;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    DropdownButton<int>(
                      value: selectedMonth,
                      dropdownColor: ColorPalette.secondary,
                      style: const TextStyle(color:ColorPalette.whiteColor, ),
                      items: List.generate(12, (index) => index + 1).map((
                        month,
                      ) {
                        return DropdownMenuItem(
                          value: month,
                          child: Text("شهر $month"),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setStateDialog(() {
                            selectedMonth = val;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "إلغاء",
                    style: TextStyle(color: ColorPalette.error),
                  ),
                ),
                CustomElevatedButton(
                  text: "تأكيد",
                  onPressed: () {
                    Navigator.pop(context);
                    onMonthSelected(DateTime(selectedYear, selectedMonth, 1));
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  static Future<DateTime?> showDailyPicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2052),
      confirmText: "تاكيد",
      cancelText: "إلغاء",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: ColorPalette.primary,
              onPrimary: ColorPalette.whiteColor,
              surface: ColorPalette.secondary,
              onSurface: ColorPalette.whiteColor,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
