import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tatbiqa/app/routes/app_images_routes.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: ColorPalette.primary,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: ColorPalette.borderColor),
            ),
            child: Text(
              'ELHAMOUL CITY',
              style: AppTextStyle.fontReadexPro14MediumBlackColor,
            ),
          ),

          Row(
            children: [
              Text(
                'تطبيقة',
                style: AppTextStyle.fontCairo18SemiBoldPrimaryColor,
              ),
              horizontalSpace(6),
              SizedBox(
                width: 24.w,
                height: 24.h,
                child: SvgPicture.asset(
                  AppImage.homeLogo,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    ColorPalette.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
