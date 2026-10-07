
import 'package:flutter/widgets.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/stat_card_widget.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key, 
    required this.firstTitle,
    required this.firstValue,
    required this.firstStyle,
    required this.secondTitle,
    required this.secondValue,
    required this.secondStyle,
  });

  final String firstTitle, firstValue, secondTitle, secondValue;
  final TextStyle firstStyle, secondStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCardWidget(
            title: firstTitle,
            value: firstValue,
            valueStyle: firstStyle,
          ),
        ),
        horizontalSpace(2),
        Expanded(
          child: StatCardWidget(
            title: secondTitle,
            value: secondValue,
            valueStyle: secondStyle,
          ),
        ),
      ],
    );
  }
}