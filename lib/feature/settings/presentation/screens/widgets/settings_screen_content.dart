import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/feature/rooms/presentation/screens/widgets/add_room_dialog.dart';
import 'package:tatbiqa/feature/settings/presentation/screens/widgets/edit_user_info.dart';

class SettingsScreenContent extends StatelessWidget {
  const SettingsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("الإعدادات", style: AppTextStyle.fontCairo24BoldWhiteColor),
            verticalSpace(16),

            EditUserInfo(),
            verticalSpace(16),

            CustomAppCard(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "إضافة غرفة",
                    style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
                  ),
                  verticalSpace(4),
                  Text(
                    "أضف غرفة جديدة وحدد اسمها وسعر الساعة.",
                    style: AppTextStyle.fontReadexPro12RegularGrayColor,
                  ),
                  verticalSpace(16),

                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: "إضافة غرفة جديدة",
                      onPressed: () => AddRoomDialog.show(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
