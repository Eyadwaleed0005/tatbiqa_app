import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/feature/rooms/presentation/screens/widgets/rooms_sliver_list.dart';
import 'package:tatbiqa/feature/rooms/presentation/screens/widgets/rooms_header_section.dart';

class RoomsScreenContent extends StatelessWidget {
  const RoomsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            sliver: SliverMainAxisGroup(
              slivers: [
                const SliverToBoxAdapter(
                  child: RoomsHeaderSection(),
                ),
                SliverToBoxAdapter(
                  child: verticalSpace(20),
                ),

                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('الغرف', style: AppTextStyle.fontCairo24BoldWhiteColor),
                      CustomElevatedButton(
                        text: 'إضافة غرفة',
                        onPressed: () {},
                        backgroundColor: ColorPalette.primary,
                        textStyle: AppTextStyle.fontReadexPro14MediumBlackColor,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: verticalSpace(16),
                ),

                const RoomsSliverList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}