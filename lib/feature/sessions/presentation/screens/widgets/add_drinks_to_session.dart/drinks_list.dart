import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/feature/products/presentation/cubit/products_cubit.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/drinks_selection_cubit.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/add_drinks_to_session.dart/drink_list_item.dart';

class DrinksList extends StatelessWidget {
  const DrinksList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, productsState) {
        if (productsState is ProductsLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (productsState is ProductsFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(productsState.error,
                  style:  TextStyle(color: ColorPalette.error)),
            ),
          );
        }
        if (productsState is ProductsSuccess) {
          final products =
              productsState.available;

          if (products.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('لا توجد منتجات متاحة',
                    style: TextStyle(color: ColorPalette.whiteColor)),
              ),
            );
          }

          return BlocBuilder<DrinksSelectionCubit, DrinksSelectionState>(
            builder: (context, selection) {
              final cubit = context.read<DrinksSelectionCubit>();
              return SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = products[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: DrinkListItem(
                        product: product,
                        quantity: selection.quantities[product.id] ?? 0,
                        onIncrement: () => cubit.change(product.id, 1),
                        onDecrement: () => cubit.change(product.id, -1),
                      ),
                    );
                  }, childCount: products.length),
                ),
              );
            },
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}