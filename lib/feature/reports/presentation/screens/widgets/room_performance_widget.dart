import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/feature/reports/domain/entity/reports_entity.dart';

class RoomPerformanceWidget extends StatelessWidget {
  final List<RoomPerformanceEntity> rooms;

  const RoomPerformanceWidget({super.key, required this.rooms});

  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "أداء الغرف",
              style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
              textAlign: TextAlign.right,
            ),
            verticalSpace(12),
            rooms.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                        "لا توجد بيانات غرف لهذه الفترة",
                        style: AppTextStyle.fontReadexPro12RegularGrayColor,
                      ),
                    ),
                  )
                : Column(
                    children: rooms.map((room) {
                      final isLast = room == rooms.last;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            room.roomName,
                            style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
                            textAlign: TextAlign.right,
                          ),
                          verticalSpace(4),
                          Text(
                            "سيشنات: ${room.sessionsCount} · ${room.totalMinutes} دقيقة · لعب: ${room.playIncome.toStringAsFixed(0)} · منتجات: ${room.productsIncome.toStringAsFixed(0)} · الإجمالي: ${room.totalIncome.toStringAsFixed(0)}",
                            style: AppTextStyle.fontReadexPro12RegularGrayColor,
                            textAlign: TextAlign.right,
                          ),
                          if (!isLast) ...[
                            verticalSpace(8),
                            const Divider(color: Colors.white24),
                            verticalSpace(8),
                          ],
                        ],
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
