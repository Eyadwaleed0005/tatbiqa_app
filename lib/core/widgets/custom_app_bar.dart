import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/app/dependency_injection/service_locator.dart';
import 'package:tatbiqa/app/routes/app_images_routes.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/feature/cafe/presentation/cubit/cafe_cubit.dart';
import 'package:tatbiqa/feature/cafe/presentation/cubit/cafe_state.dart';

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
            child: BlocProvider(
              create: (context) => getIt.get<CafeCubit>()..getCafeInfo(),
              child: BlocBuilder<CafeCubit, CafeState>(
                builder: (context, state) {
                  if (state is GetDataCafeSuccess) {
                    return Text(
                      state.cafeEntity.cafeName,
                      style: AppTextStyle.fontReadexPro14MediumBlackColor,
                    );
                  } else if (state is GetDataCafeError) {
                    return Text(
                      state.message,
                      style: AppTextStyle.fontReadexPro14MediumBlackColor,
                    );
                  } else {
                    return Text(
                      "Guess",
                      style: AppTextStyle.fontReadexPro14MediumBlackColor,
                    );
                  }
                },
              ),
            ),
          ),

          Row(
            children: [
              Text(
                'تطبيقة',
                style: AppTextStyle.fontCairo18SemiBoldPrimaryColor,
              ),
              horizontalSpace(12),
              Image.asset(AppImage.homeLogo, fit: BoxFit.contain),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
