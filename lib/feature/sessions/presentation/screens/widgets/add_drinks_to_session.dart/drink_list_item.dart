import 'package:flutter/material.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/feature/products/domain/entity/products_entity.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/add_drinks_to_session.dart/drink_action_icon.dart';

class DrinkListItem extends StatelessWidget {
  final ProductEntity product;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const DrinkListItem({
    super.key,
    required this.product,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = product.isAvailable;

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
                  isAvailable ? '$quantity' : 'نفد',
                  style: isAvailable
                      ? AppTextStyle.fontReadexPro14MediumWhiteColor
                      : AppTextStyle.fontReadexPro14MediumGrayColor,
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
                  product.name,
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
                    horizontalSpace(4),
                    Text(
                      '${product.price}',
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