import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/feature/sessions/data/model/drink_item_model.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/add_drinks_to_session.dart/drink_list_item.dart';

class DrinksList extends StatelessWidget {
  final List<DrinkItem> drinks;
  final VoidCallback onChanged;

  const DrinksList({super.key, required this.drinks, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final drink = drinks[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: DrinkListItem(
              drink: drink,
              onIncrement: () {
                drink.quantity++;
                onChanged();
              },
              onDecrement: () {
                if (drink.quantity > 0) {
                  drink.quantity--;
                  onChanged();
                }
              },
            ),
          );
        }, childCount: drinks.length),
      ),
    );
  }
}
