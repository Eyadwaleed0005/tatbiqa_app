import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/app/dependency_injection/service_locator.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/core/helper/helper_functions.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/app_custom_dialog.dart';
import 'package:tatbiqa/core/widgets/app_toast.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/rooms_cubit.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/sessions_cubit.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/sessions_state.dart';

class EndSessionDialog extends StatelessWidget {
  final SessionEntity session;
  final List<SessionProductEntity> orders;

  const EndSessionDialog({
    super.key,
    required this.session,
    required this.orders,
  });

  static void show(
    BuildContext context, {
    required SessionEntity session,
    required List<SessionProductEntity> orders,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt.get<SessionsCubit>()),
          BlocProvider(create: (context) => getIt.get<RoomsCubit>()),
        ],
        child: EndSessionDialog(session: session, orders: orders),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final duration = now.difference(session.startTime);
    final durationMinutes = duration.inMinutes;
    final playCost = HelperFunctions.calculatePlayCost(session);
    final productsCost = orders.fold<double>(0, (sum, o) => sum + o.totalPrice);
    final totalCost = playCost + productsCost;

    return BlocListener<SessionsCubit, SessionsState>(
      listener: (context, state) {
        if (state is SessionCheckoutSuccess) {
          AppToast.show(context, "تم إنهاء السيشن بنجاح وتحديث الغرفة");

          context.read<RoomsCubit>().getRooms();

          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.main,
            (route) => false,
          );
        }
      },
      child: AppCustomDialog(
        confirmButtonText: 'تأكيد إغلاق السيشن',
        onConfirm: () {
          context.read<SessionsCubit>().endSession(
            sessionId: session.id,
            playstationCost: playCost,
            productsCost: productsCost,
            totalCost: totalCost,
            durationMinutes: durationMinutes,
          );
                   Navigator.pop(context);
 
        },
        contentChild: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "تأكيد إنهاء السيشن",
              style: AppTextStyle.fontCairo24BoldWhiteColor,
            ),
            verticalSpace(12),
            Text(
              "الغرفة: ${session.roomName}",
              style: AppTextStyle.fontReadexPro14RegularGrayColor,
            ),
            verticalSpace(4),
            Text(
              "وقت البداية: ${HelperFunctions.formatStartTime(session.startTime)}",
              style: AppTextStyle.fontReadexPro14RegularGrayColor,
            ),
            verticalSpace(4),
            Text(
              "وقت النهاية: ${HelperFunctions.formatStartTime(now)}",
              style: AppTextStyle.fontReadexPro14RegularGrayColor,
            ),
            verticalSpace(4),
            Text(
              "مدة اللعب: $durationMinutes دقيقة",
              style: AppTextStyle.fontReadexPro14RegularGrayColor,
            ),
            verticalSpace(12),
            Text(
              "تكلفة البليستيشن: ${playCost.toStringAsFixed(2)} ج.م",
              style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
            ),
            verticalSpace(4),
            Text(
              "إجمالي المشروبات: ${productsCost.toStringAsFixed(2)} ج.م",
              style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
            ),
            verticalSpace(12),
            Text(
              "الطلبات",
              style: AppTextStyle.fontReadexPro12RegularGrayColor,
            ),
            verticalSpace(6),
            if (orders.isEmpty)
              Text(
                "لا توجد طلبات",
                style: AppTextStyle.fontReadexPro12RegularGrayColor,
              )
            else
              ...orders.map(
                (o) => Text(
                  "${o.productName} × ${o.quantity} = ${o.totalPrice.toStringAsFixed(2)} ج.م",
                  style: AppTextStyle.fontReadexPro12RegularGrayColor,
                ),
              ),
            verticalSpace(16),
            Text(
              "الإجمالي النهائي: ${totalCost.toStringAsFixed(2)} ج.م",
              style: AppTextStyle.fontCairo24BoldPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
