import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_text_form_field.dart';

class RoomSettingsScreenContent extends StatefulWidget {
  const RoomSettingsScreenContent({super.key});

  @override
  State<RoomSettingsScreenContent> createState() =>
      _RoomSettingsScreenContentState();
}

class _RoomSettingsScreenContentState extends State<RoomSettingsScreenContent> {
  final TextEditingController roomNameController = TextEditingController();
  final TextEditingController roomPriceController = TextEditingController();

  @override
  void dispose() {
    roomNameController.dispose();
    roomPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إعدادات الغرفة',
                style: AppTextStyle.fontCairo24BoldWhiteColor,
              ),
              verticalSpace(6),

              Text(
                'يمكن تعديل الغرفة أو حذفها وهي متاحة فقط.',
                style: AppTextStyle.fontReadexPro12RegularGrayColor,
              ),
              verticalSpace(32),

              CustomTextFormField(
                controller: roomNameController,
                labelText: 'اسم الغرفة',
                hintText: 'غرفة 01',
              ),
              verticalSpace(20),

              CustomTextFormField(
                controller: roomPriceController,
                labelText: 'سعر الساعة',
                hintText: '50 ج.م',
                keyboardType: TextInputType.text,
              ),
              verticalSpace(40),

              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  text: 'حفظ التغييرات',
                  backgroundColor: ColorPalette.primary,

                  onPressed: () {},
                ),
              ),
              verticalSpace(16),

              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  text: 'حذف الغرفة',
                  backgroundColor: ColorPalette.statusDanger,

                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
