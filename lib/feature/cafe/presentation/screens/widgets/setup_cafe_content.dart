import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/feature/cafe/presentation/screens/widgets/setup_cafe_form.dart';

class SetupCafeContent extends StatefulWidget {
  const SetupCafeContent({super.key});

  @override
  State<SetupCafeContent> createState() => _SetupCafeContentState();
}

class _SetupCafeContentState extends State<SetupCafeContent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
          child: CustomAppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('تطبيقة', style: AppTextStyle.fontCairo24BoldPrimaryColor),
                verticalSpace(8),

                Text('جهز محلك', style: AppTextStyle.fontCairo32BoldWhiteColor),
                verticalSpace(4),

                Text(
                  'أدخل اسم المحل لأول مرة لبدء الاستخدام',
                  style: AppTextStyle.fontReadexPro14RegularGrayColor,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(24),

                SetupCafeForm(),

                Text(
                  ' . بعد الحفظ سنتنقل إلى شاشة الغرف',
                  style: AppTextStyle.fontReadexPro12RegularGrayColor,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
