import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tatbiqa/feature/rooms/presentation/screens/widgets/rooms_sliver_list.dart';

class RoomsScreenContent extends StatelessWidget {
  const RoomsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            sliver: const RoomsSliverList(),
          ),
        ],
      ),
    );
  }
}
