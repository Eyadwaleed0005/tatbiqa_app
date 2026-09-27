import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/feature/products/presentation/screens/widgets/add_edit_product_dialog.dart';
import 'package:tatbiqa/feature/products/presentation/screens/widgets/products_list.dart';

class ProductScreenContent extends StatelessWidget {
  const ProductScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المنتجات',
                      style: AppTextStyle.fontCairo24BoldWhiteColor,
                    ),
                    SizedBox(
                      width: 140.w,
                      child: CustomElevatedButton(
                        text: 'إضافة منتج',
                        onPressed: () => AddEditProductDialog.show(context),
                      ),
                    ),
                  ],
                ),
                verticalSpace(16),
              ],
            ),
          ),
        ),

        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: const ProductsList(),
        ),
      ],
    );
  }
}
