import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_animations.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/app_toast.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_outlined_button.dart';
import 'package:tatbiqa/feature/products/domain/entity/products_entity.dart';
import 'package:tatbiqa/feature/products/presentation/cubit/products_cubit.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/rooms_cubit.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/drinks_selection_cubit.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/session_product_cubit.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/session_product_state.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/add_drinks_to_session.dart/drink_total_card.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/add_drinks_to_session.dart/drinks_list.dart';

class AddDrinksToSessionContent extends StatelessWidget {
  final SessionEntity session;

  const AddDrinksToSessionContent({super.key, required this.session});

  List<ProductEntity> _availableProducts(BuildContext context) {
     final state = context.read<ProductsCubit>().state;
  return state is ProductsSuccess ? state.available : [];
  }

  void _submit(BuildContext context) {
    final items = context
        .read<DrinksSelectionCubit>()
        .buildItems(session.id, _availableProducts(context));

    if (items.isEmpty) {
      AppToast.show(context, 'اختر منتج واحد على الأقل');
      return;
    }
    context.read<SessionProductCubit>().addProductsToSession(items);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionProductCubit, SessionProductState>(
      listener: (context, state) {
        if (state is SessionProductAdded) {
          context.read<DrinksSelectionCubit>().reset();
          context.read<RoomsCubit>().getRooms();
          Navigator.pop(context);
        } else if (state is SessionProductError) {
          AppToast.show(context, state.message);
        }
      },
      child: AppAnimations.screenSection(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${session.roomName} · سيشن شغّال',
                        style: AppTextStyle.fontReadexPro12MediumPrimaryColor,
                      ),
                      Text(
                        'إضافة طلبات',
                        style: AppTextStyle.fontCairo24BoldWhiteColor,
                      ),
                    ],
                  ),
                  verticalSpace(12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'اختر الكمية ثم أضفها إلى الحساب الحالي',
                      style: AppTextStyle.fontReadexPro14RegularGrayColor,
                    ),
                  ),
                  verticalSpace(12),
                ]),
              ),
            ),

            const DrinksList(),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  verticalSpace(8),
                  BlocBuilder<DrinksSelectionCubit, DrinksSelectionState>(
                    builder: (context, _) {
                      context.watch<ProductsCubit>();
                      final total = context
                          .read<DrinksSelectionCubit>()
                          .total(_availableProducts(context));
                      return DrinkTotalCard(totalAmount: total);
                    },
                  ),

                  verticalSpace(8),

                  BlocBuilder<SessionProductCubit, SessionProductState>(
                    builder: (context, state) {
                      final isLoading = state is SessionProductLoading;
                      return SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          text: isLoading
                              ? 'جاري الإضافة...'
                              : 'إضافة إلى السيشن',
                          onPressed: isLoading ? () {} : () => _submit(context),
                        ),
                      );
                    },
                  ),

                  verticalSpace(80),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 120.w,
                      child: CustomOutlinedButton(
                        text: 'رجوع',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  verticalSpace(16),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}