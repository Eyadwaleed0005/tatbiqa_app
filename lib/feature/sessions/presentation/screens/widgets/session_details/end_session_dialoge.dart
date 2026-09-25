import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_outlined_button.dart';

class EndSessionDialog extends StatelessWidget {
  const EndSessionDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const EndSessionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorPalette.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "تأكيد إنهاء السيشن",
                style: AppTextStyle.fontCairo24BoldWhiteColor,
              ),
              verticalSpace(12),

              Text(
                "الغرفة: غرفة 02",
                style: AppTextStyle.fontReadexPro14RegularGrayColor,
              ),
              verticalSpace(4),
              Text(
                "وقت البداية: 08:15 م",
                style: AppTextStyle.fontReadexPro14RegularGrayColor,
              ),
              verticalSpace(4),
              Text(
                "وقت النهاية: 09:40 م",
                style: AppTextStyle.fontReadexPro14RegularGrayColor,
              ),
              verticalSpace(4),
              Text(
                "مدة اللعب: 85 دقيقة",
                style: AppTextStyle.fontReadexPro14RegularGrayColor,
              ),

              verticalSpace(12),

              Text(
                "تكلفة البليستيشن: 85 ج.م",
                style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
              ),
              verticalSpace(4),
              Text(
                "إجمالي المشروبات: 55 ج.م",
                style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
              ),

              verticalSpace(12),
              Text(
                "الطلبات",
                style: AppTextStyle.fontReadexPro12RegularGrayColor,
              ),
              verticalSpace(6),
              Text(
                "شاي × 2 = 20 ج.م",
                style: AppTextStyle.fontReadexPro12RegularGrayColor,
              ),
              Text(
                "بيبسي × 1 = 15 ج.م",
                style: AppTextStyle.fontReadexPro12RegularGrayColor,
              ),
              Text(
                "قهوة × 1 = 20 ج.م",
                style: AppTextStyle.fontReadexPro12RegularGrayColor,
              ),

              verticalSpace(16),

              Text(
                "الإجمالي النهائي: 140 ج.م",
                style: AppTextStyle.fontCairo24BoldPrimaryColor,
              ),

              verticalSpace(24),

              SizedBox(
                width: double.infinity,

                child: CustomElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "تأكيد إغلاق السيشن",
                ),
              ),
              verticalSpace(10),
              SizedBox(
                width: double.infinity,
                child: CustomOutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "إلغاء",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
