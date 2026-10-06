import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/empty_or_error_state.dart';
import 'package:tatbiqa/feature/products/presentation/cubit/products_cubit.dart';
import 'package:tatbiqa/feature/products/presentation/screens/widgets/add_edit_product_dialog.dart';
import 'package:tatbiqa/feature/products/presentation/screens/widgets/product_item_card.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsSuccess && state.productEntity.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('المنتجات', style: AppTextStyle.fontCairo24BoldWhiteColor),
                verticalSpace(40),
                Expanded(
                  child: EmptyOrErrorState(
                    title: 'لم يتم إضافة منتجات بعد',
                    description: 'يمكنك إضافة منتج جديد',
                    actionButton: CustomElevatedButton(
                      text: "إضافة منتج",
                      onPressed: () => AddEditProductDialog.show(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // 2. حالة الخطأ
        if (state is ProductsFailure) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('المنتجات', style: AppTextStyle.fontCairo24BoldWhiteColor),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: EmptyOrErrorState(
                        title: 'حدث خطأ ما',
                        description: state.error,
                        actionButton: SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            icon: Icon(
                              Icons.restore_outlined,
                              color: ColorPalette.blackColor,
                            ),
                            text: "إعادة المحاولة",
                            onPressed: () {
                              context.read<ProductsCubit>().fetchProdcts();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is ProductsLoading) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ProductsSuccess) {
          final products = state.productEntity;
          return SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(child: verticalSpace(20)),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المنتجات',
                      style: AppTextStyle.fontCairo24BoldWhiteColor,
                    ),
                    CustomElevatedButton(
                      text: 'إضافة منتج',
                      onPressed: () => AddEditProductDialog.show(context),
                      backgroundColor: ColorPalette.primary,
                      textStyle: AppTextStyle.fontReadexPro14MediumBlackColor,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(16)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: ProductItemCard(product: product),
                    );
                  },
                  childCount: products.length,
                ),
              ),
            ],
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}