
import 'package:flutter/material.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/feature/products/presentation/screens/widgets/product_item_card.dart';

class ProductsList extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
      
        const ProductItemCard(
          productName: 'شاي كشميري — 12 ج.م',
          isAvailable: true,
        ),
        verticalSpace(12),
        const ProductItemCard(
          productName: 'بيسي — 15 ج.م',
          isAvailable: true,
        ),
        verticalSpace(12),
        const ProductItemCard(
          productName: 'قهوة — 20 ج.م',
          isAvailable: false,
        ),
      ]),
    );
  }
}
