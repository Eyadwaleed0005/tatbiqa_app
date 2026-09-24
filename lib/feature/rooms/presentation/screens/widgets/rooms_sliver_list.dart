import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/feature/rooms/presentation/screens/widgets/room_card_item.dart';

class RoomsSliverList extends StatelessWidget {
  const RoomsSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> roomsList = [
      {
        'name': 'غرفة 01',
        'status': 'متاحة',
        'isBusy': false,
        'hourlyRate': '50 ج.م',
        'todayIncome': '300 ج.م',
        'sessionsCount': '4',
      },
      {
        'name': 'غرفة 02',
        'status': 'مشغولة',
        'isBusy': true,
        'hourlyRate': '60 ج.م',
        'startTime': '08:15 م',
        'currentDuration': '01:36:37',
        'currentTotal': '140 ج.م',
        'todayIncome': '460 ج.م',
        'sessionsCount': '6',
      },
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final room = roomsList[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: RoomCardItem(roomData: room),
          );
        },
        childCount: roomsList.length,
      ),
    );
  }
}