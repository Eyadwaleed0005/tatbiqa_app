import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_outlined_button.dart';
import 'package:tatbiqa/feature/sessions/data/model/drink_item_model.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/add_drinks_to_session.dart/drink_total_card.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/add_drinks_to_session.dart/drinks_list.dart';

class AddDrinksToSessionContent extends StatefulWidget {
  const AddDrinksToSessionContent({super.key});

  @override
  State<AddDrinksToSessionContent> createState() =>
      _AddDrinksToSessionContentState();
}

class _AddDrinksToSessionContentState extends State<AddDrinksToSessionContent> {
  final List<DrinkItem> drinks = [
    DrinkItem(name: 'شاي كشميري', price: 12),
    DrinkItem(name: 'بيبسي', price: 7),
    DrinkItem(name: 'قهوة تركي', price: 10, isAvailable: false),
  ];

  int get totalAmount {
    int total = 0;
    for (var drink in drinks) {
      if (drink.isAvailable) {
        total += (drink.price * drink.quantity);
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                    'غرفة 03 · سيشن شغّال',
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

        DrinksList(
          drinks: drinks,
          onChanged: () {
            setState(() {});
          },
        ),

        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              verticalSpace(8),
              DrinkTotalCard(totalAmount: totalAmount),
              verticalSpace(8),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  text: 'إضافة إلى السيشن',
                  onPressed: () {},
                ),
              ),
              verticalSpace(80),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 120.w,
                  child: CustomOutlinedButton(
                    text: 'رجوع',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              verticalSpace(16),
            ]),
          ),
        ),
      ],
    );
  }
}
