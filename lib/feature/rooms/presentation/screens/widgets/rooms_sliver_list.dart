import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/empty_or_error_state.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/rooms_cubit.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/rooms_state.dart';
import 'package:tatbiqa/feature/rooms/presentation/screens/widgets/add_room_dialog.dart';
import 'package:tatbiqa/feature/rooms/presentation/screens/widgets/room_card_item.dart';

class RoomsSliverList extends StatelessWidget {
  const RoomsSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsCubit, RoomsState>(
      builder: (context, state) {
        if (state is RoomsEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('الغرف', style: AppTextStyle.fontCairo24BoldWhiteColor),
                verticalSpace(40),

                Expanded(
                  child: EmptyOrErrorState(
                    title: 'لم يتم إضافة غرف بعد',
                    description: 'يمكنك إضافة غرفة',
                    actionButton: CustomElevatedButton(
                      text: "إضافة غرفة",
                      onPressed: () => AddRoomDialog.show(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is RoomsError) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('الغرف', style: AppTextStyle.fontCairo24BoldWhiteColor),

                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: EmptyOrErrorState(
                        title: 'حدث خطأ ما',
                        description: state.errMessage,
                        actionButton: SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            icon: Icon(
                              Icons.restore_outlined,
                              color: ColorPalette.blackColor,
                            ),
                            text: "إعادة المحاولة",
                            onPressed: () {
                              context.read<RoomsCubit>().getRooms();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is RoomsLoaded) {
          final rooms = state.rooms;
          return SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(child: verticalSpace(20)),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الغرف',
                      style: AppTextStyle.fontCairo24BoldWhiteColor,
                    ),
                    CustomElevatedButton(
                      text: 'إضافة غرفة',
                      onPressed: () => AddRoomDialog.show(context),
                      backgroundColor: ColorPalette.primary,
                      textStyle: AppTextStyle.fontReadexPro14MediumBlackColor,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(16)),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final room = rooms[index];

                  final activeSession = state.activeSessionsMap[room.id];
                  final roomStats = state.roomsStatsMap[room.id];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: RoomCardItem(
                      room: room,
                      activeSession: activeSession,
                      roomStats: roomStats,
                    ),
                  );
                }, childCount: rooms.length),
              ),
            ],
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
