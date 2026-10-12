
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/app/routes/app_images_routes.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/widgets/main_navigation_bar/custom_nav_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 12.h,
            left: 16.w,
            right: 16.w,
            child: Container(
              height: 64.h,
              decoration: BoxDecoration(
                color: ColorPalette.secondary,
                borderRadius: BorderRadius.circular(35.r),
                border: Border.all(color: ColorPalette.borderColor),
                boxShadow: [
                  BoxShadow(
                    color: ColorPalette.blackColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomNavItem(
                      iconPath:AppImage.settingsLogo,
                      index: 0,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                    CustomNavItem(
                      iconPath:AppImage.historyLogo ,
                      index: 1,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                    CustomNavItem(
                      iconPath: AppImage.playLogo,
                      index: 2,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                    CustomNavItem(
                      iconPath: AppImage.archiveLogo,
                      index: 3,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                    CustomNavItem(
                      iconPath: AppImage.editLogo,
                      index: 4,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}