
import 'package:flutter/widgets.dart';
import 'package:tatbiqa/feature/reports/presentation/screens/widgets/custom_tabs_widget.dart';

class DashboardTabs extends StatelessWidget {
  const DashboardTabs({super.key, 
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTabsWidget(
      selectedIndex: selectedIndex,
      onTabChanged: onTabChanged,
    );
  }
}