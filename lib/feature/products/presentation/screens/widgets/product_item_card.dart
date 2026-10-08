import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/core/widgets/custom_outlined_button.dart';
import 'package:tatbiqa/feature/products/domain/entity/products_entity.dart';
import 'package:tatbiqa/feature/products/presentation/cubit/products_cubit.dart';
import 'package:tatbiqa/feature/products/presentation/screens/widgets/add_edit_product_dialog.dart';

class ProductItemCard extends StatelessWidget {
  final ProductEntity product;

  const ProductItemCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = product.isAvailable; 

    return CustomAppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${product.name} — ${product.price} ج.م',
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
                  onPressed: () => AddEditProductDialog.show(
                    context,
                 product: product,
                  ),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: CustomElevatedButton(
                  text: 'حذف',
                  backgroundColor: ColorPalette.statusDanger,
                  textStyle: AppTextStyle.fontReadexPro14MediumBlackColor,
                  onPressed: () {
                    context.read<ProductsCubit>().deleteProduct(id: product.id).then((_) {
        context.read<ProductsCubit>().fetchProdcts();
      });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}