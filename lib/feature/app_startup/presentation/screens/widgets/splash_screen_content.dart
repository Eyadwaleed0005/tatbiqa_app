import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tatbiqa/app/routes/app_images_routes.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/feature/app_startup/presentation/screens/widgets/dashed_circles_widget.dart';
import 'package:tatbiqa/feature/app_startup/presentation/screens/widgets/splash_loading_bar.dart';

class SplashScreenContent extends StatefulWidget {
  const SplashScreenContent({super.key});

  @override
  State<SplashScreenContent> createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends State<SplashScreenContent>
    with TickerProviderStateMixin {
  late AnimationController _circlesController;

  late AnimationController _imagePopupController;
  late Animation<double> _imageScaleAnimation;
  late Animation<double> _imagePopupFadeAnimation;

  late AnimationController _textPopupController;
  late Animation<double> _textScaleAnimation;
  late Animation<double> _textPopupFadeAnimation;

  late AnimationController _imageFloatController;
  late Animation<double> _imageFloatAnimation;

  late AnimationController _textFloatController;
  late Animation<double> _textFloatAnimation;

  bool _canStartLoading = false;

  @override
  void initState() {
    super.initState();

    _circlesController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    _imagePopupController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _imageScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _imagePopupController, curve: Curves.easeOutBack),
    );

    _imagePopupFadeAnimation = CurvedAnimation(
      parent: _imagePopupController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    );

    _textPopupController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _textScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textPopupController, curve: Curves.easeOutBack),
    );

    _textPopupFadeAnimation = CurvedAnimation(
      parent: _textPopupController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    );

    _imageFloatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _imageFloatAnimation = Tween<double>(begin: -7.0, end: 7.0).animate(
      CurvedAnimation(parent: _imageFloatController, curve: Curves.easeInOut),
    );

    _textFloatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _textFloatAnimation = Tween<double>(begin: -3.0, end: 3.0).animate(
      CurvedAnimation(parent: _textFloatController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) await _imagePopupController.forward();

      if (mounted) await _textPopupController.forward();

      if (mounted) {
        setState(() {
          _canStartLoading = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _circlesController.dispose();
    _imagePopupController.dispose();
    _textPopupController.dispose();
    _imageFloatController.dispose();
    _textFloatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _circlesController,
        _imagePopupController,
        _textPopupController,
        _imageFloatController,
        _textFloatController,
      ]),
      builder: (context, child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorPalette.blackColor,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFF131d30), ColorPalette.blackColor],
              stops: const [0.3, 0.7],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Column(
                  children: [
                    FadeTransition(
                      opacity: _imagePopupFadeAnimation,
                      child: ScaleTransition(
                        scale: _imageScaleAnimation,
                        child: DashedCirclesWidget(
                          thisChild: Transform.translate(
                            offset: Offset(_imageFloatAnimation.value, 0),
                            child: SvgPicture.asset(
                              AppImage.splashLogo,
                              width: 270.w,
                              height: 270.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(20),
                    FadeTransition(
                      opacity: _textPopupFadeAnimation,
                      child: ScaleTransition(
                        scale: _textScaleAnimation,
                        child: Transform.translate(
                          offset: Offset(0, _textFloatAnimation.value),
                          child: Column(
                            children: [
                              Text(
                                'تطبيقة',
                                style: AppTextStyle.fontCairo32BoldWhiteColor,
                              ),
                              verticalSpace(6),
                              Text(
                                'تطبيق إدارة صالات البلايستيشن',
                                style: AppTextStyle
                                    .fontReadexPro14RegularGrayColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (_canStartLoading) ...[
                      Text(
                        'اكتمال مزامنة النظام',
                        style: AppTextStyle.fontReadexPro10MediumGrayColor,
                      ),
                      verticalSpace(6),
                      SplashLoadingBar(
                        duration: const Duration(seconds: 3),
                        onCompleted: () {
                          Navigator.pushNamed(context, RouteNames.setupCafe);
                        },
                      ),
                    ],
                  ],
                ),
                verticalSpace(100),
              ],
            ),
          ),
        );
      },
    );
  }
}
