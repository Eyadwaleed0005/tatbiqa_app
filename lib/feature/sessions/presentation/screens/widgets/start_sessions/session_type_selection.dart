import 'package:flutter/material.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/start_sessions/session_type_card.dart';

class SessionTypeSelection extends StatefulWidget {
  const SessionTypeSelection({super.key});

  @override
  State<SessionTypeSelection> createState() => _SessionTypeSelectionState();
}

class _SessionTypeSelectionState extends State<SessionTypeSelection> {
  bool isIndividual = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "اختر نوع السيشن",
            style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
          ),
        ),
        verticalSpace(4),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "حدد طريقة اللعب قبل بدء السيشن",
            style: AppTextStyle.fontReadexPro14RegularGrayColor,
          ),
        ),
        verticalSpace(16),
        Row(
          children: [
            Expanded(
              child: SessionTypeCard(
                title: "فردي",
                icon: Icons.person_outline,
                isSelected: isIndividual,
                onTap: () => setState(() => isIndividual = true),
              ),
            ),
            horizontalSpace(16),
            Expanded(
              child: SessionTypeCard(
                title: "زوجي",
                icon: Icons.people_outline,
                isSelected: !isIndividual,
                onTap: () => setState(() => isIndividual = false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
