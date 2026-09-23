
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/feature/app_startup/presentation/screens/widgets/dashed_circle_painter.dart';

class DashedCirclesWidget extends StatefulWidget {
  const DashedCirclesWidget({super.key, required this.thisChild});

  final Widget thisChild;

  @override
  State<DashedCirclesWidget> createState() => _DashedCirclesWidgetState();
}

class _DashedCirclesWidgetState extends State<DashedCirclesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return RepaintBoundary(
          child: CustomPaint(
            painter: DashedCirclePainter(animationValue: _controller.value),
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: widget.thisChild,
            ),
          ),
        );
      },
    );
  }
}


