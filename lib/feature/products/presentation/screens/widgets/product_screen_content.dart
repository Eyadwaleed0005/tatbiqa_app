import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/style/app_animations.dart';
import 'package:tatbiqa/feature/products/presentation/screens/widgets/products_list.dart';

class ProductScreenContent extends StatefulWidget {
  const ProductScreenContent({super.key});

  @override
  State<ProductScreenContent> createState() => _ProductScreenContentState();
}

class _ProductScreenContentState extends State<ProductScreenContent> {


  @override
  Widget build(BuildContext context) {
    return AppAnimations.screenSection(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              sliver: 
                ProductsList(),
              
            ),
          ],
        ),
      ),
    );
  }
}