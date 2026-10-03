import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_animations.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/app_toast.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/sessions_cubit.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/sessions_state.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/start_sessions/session_type_selection.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/start_sessions/start_session_header_section.dart';

class StartSessionContent extends StatelessWidget {
  final RoomEntity room; 

  const StartSessionContent({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionsCubit, SessionsState>(
      listener: (context, state) {
        if (state is SessionStartedSuccess) {
          AppToast.show(context, "تم بدء السيشن بنجاح");
Navigator.pop(context);         
        } else if (state is SessionsError) {
          AppToast.show(context, state.message);
        }
      },
      builder: (context, state) {
        bool isLoading = state is SessionsLoading;

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: AppAnimations.screenSection(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StartSessionHeaderSection(),
                  verticalSpace(16),
                  CustomAppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "متاحة",
                                  style: AppTextStyle
                                      .fontReadexPro14MediumPrimaryColor,
                                ),
                                horizontalSpace(6),
                                Container(
                                  width: 8.w,
                                  height: 8.h,
                                  decoration: const BoxDecoration(
                                    color: ColorPalette.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              room.name,
                              style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
                            ),
                          ],
                        ),
                        verticalSpace(12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "سعر الساعة: ${room.hourlyRate} ج.م  •  جاهزة لبدء سيشن",
                            style: AppTextStyle.fontReadexPro14RegularGrayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(24),
                  const SessionTypeSelection(),
                  verticalSpace(200),
                  Center(
                    child: Text(
                      "سيبدأ احتساب الوقت فور تأكيد بدء السيشن.",
                      style: AppTextStyle.fontReadexPro14RegularGrayColor,
                    ),
                  ),
                  verticalSpace(16),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: isLoading ? "جاري البدء..." : "بدء سيشن",
                      onPressed: () {
                        if (isLoading) return;

                        context.read<SessionsCubit>().startSession(
                          roomId: room.id,
                          roomName: room.name,
                          hourlyRate: room.hourlyRate,
                        );
                      },
                    ),
                  ),
                  verticalSpace(16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
