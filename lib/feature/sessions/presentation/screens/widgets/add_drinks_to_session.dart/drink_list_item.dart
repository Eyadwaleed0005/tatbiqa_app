import 'package:flutter/material.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/feature/sessions/data/model/drink_item_model.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/add_drinks_to_session.dart/drink_action_icon.dart';

class DrinkListItem extends StatelessWidget {
  final DrinkItem drink;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const DrinkListItem({
    super.key,
    required this.drink,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = drink.isAvailable;

    return Opacity(
      opacity: isAvailable ? 1.0 : 0.5,
      child: CustomAppCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                DrinkActionIcon(
                  icon: Icons.remove,
                  onTap: isAvailable ? onDecrement : null,
                  isAvailable: isAvailable,
                ),
                horizontalSpace(16),

                Text(
                  isAvailable ? '${drink.quantity}' : 'نفد',
                  style: isAvailable
                      ? AppTextStyle.fontReadexPro14MediumWhiteColor
                      : AppTextStyle.fontReadexPro14MediumGraykColor,
                ),
                horizontalSpace(16),

                DrinkActionIcon(
                  icon: Icons.add,
                  onTap: isAvailable ? onIncrement : null,
                  isAvailable: isAvailable,
                ),
                horizontalSpace(16),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  drink.name,
                  style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
                ),
                verticalSpace(2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'ج.م',
                      style: isAvailable
                          ? AppTextStyle.fontReadexPro12RegularAmberColor
                          : AppTextStyle.fontReadexPro12RegularGrayColor,
                    ),
                    horizontalSpace( 4), 
                    Text(
                      '${drink.price}',
                      style: isAvailable
                          ? AppTextStyle.fontReadexPro12RegularAmberColor
                          : AppTextStyle.fontReadexPro12RegularGrayColor,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
