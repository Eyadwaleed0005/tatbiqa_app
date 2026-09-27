import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/core/widgets/custom_outlined_button.dart';
import 'package:tatbiqa/feature/products/presentation/screens/widgets/add_edit_product_dialog.dart';

class ProductItemCard extends StatelessWidget {
  final String productName;
  final bool isAvailable;

  const ProductItemCard({
    super.key,
    required this.productName,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                productName,
                style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
              ),
              verticalSpace(4),
              Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    isAvailable ? 'متاح' : 'غير متاح',
                    style: isAvailable
                        ? AppTextStyle.fontReadexPro14MediumGreenColor
                        : AppTextStyle.fontReadexPro14MediumGrayColor,
                  ),
                  horizontalSpace(6),
                  Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isAvailable
                          ? ColorPalette.success
                          : ColorPalette.gray,
                    ),
                  ),
                ],
              ),
            ],
          ),
          verticalSpace(16),

          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  text: 'تعديل',
                  borderColor: ColorPalette.borderColor,
                  backgroundColor: ColorPalette.secondary,
                  textStyle: AppTextStyle.fontReadexPro14MediumWhiteColor,
                  onPressed: () =>AddEditProductDialog.show(context),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: CustomElevatedButton(
                  text: 'حذف',
                  backgroundColor: ColorPalette.statusDanger,
                  textStyle: AppTextStyle.fontReadexPro14MediumBlackColor,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
