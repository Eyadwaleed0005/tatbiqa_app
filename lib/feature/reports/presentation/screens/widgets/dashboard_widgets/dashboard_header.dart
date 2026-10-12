
import 'package:flutter/widgets.dart';
import 'package:tatbiqa/core/style/textstyles.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key, this.isCentered = false});

  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCentered ? Alignment.center : Alignment.centerRight,
      child: Text(
        "لوحة التقارير",
        style: AppTextStyle.fontCairo24BoldWhiteColor,
        textAlign: isCentered ? TextAlign.center : TextAlign.right,
      ),
    );
  }
}
