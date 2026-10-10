import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_text_form_field.dart';
import 'package:tatbiqa/core/widgets/custom_operation_result_dialog.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/room_settings_cubit.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/room_settings_state.dart';

class RoomSettingsScreenContent extends StatefulWidget {
  final RoomEntity room;

  const RoomSettingsScreenContent({super.key, required this.room});

  @override
  State<RoomSettingsScreenContent> createState() =>
      _RoomSettingsScreenContentState();
}

class _RoomSettingsScreenContentState extends State<RoomSettingsScreenContent> {
  late final TextEditingController roomNameController;
  late final TextEditingController roomPriceController;

  @override
  void initState() {
    super.initState();
    roomNameController = TextEditingController(text: widget.room.name);
    roomPriceController = TextEditingController(
      text: widget.room.hourlyRate.toStringAsFixed(0),
    );
  }

  @override
  void dispose() {
    roomNameController.dispose();
    roomPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomSettingsCubit, RoomSettingsState>(
      listener: (context, state) {
        if (state is RoomUpdateSuccess || state is RoomDeleteSuccess) {
          final message = state is RoomUpdateSuccess
              ? state.message
              : (state as RoomDeleteSuccess).message;

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => CustomOperationResultDialog(
              type: CustomOperationResultType.success,
              title: 'تم بنجاح',
              message: message,
              actionText: 'متابعة',
              onActionPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop();
              },
            ),
          );
        } else if (state is RoomUpdateFailure || state is RoomDeleteFailure) {
          final error = state is RoomUpdateFailure
              ? state.error
              : (state as RoomDeleteFailure).error;

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => CustomOperationResultDialog(
              type: CustomOperationResultType.failure,
              title: 'حدث خطأ',
              message: error,
              actionText: 'متابعة',
              onActionPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          );
        }
      },
      builder: (context, state) {
        final isUpdating = state is RoomUpdateLoading;
        final isDeleting = state is RoomDeleteLoading;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'إعدادات الغرفة',
                    style: AppTextStyle.fontCairo24BoldWhiteColor,
                  ),
                  verticalSpace(6),
                  Text(
                    'يمكن تعديل الغرفة أو حذفها وهي متاحة فقط.',
                    style: AppTextStyle.fontReadexPro12RegularGrayColor,
                  ),
                  verticalSpace(32),
                  CustomTextFormField(
                    controller: roomNameController,
                    labelText: 'اسم الغرفة',
                    hintText: 'غرفة 01',
                  ),
                  verticalSpace(20),
                  CustomTextFormField(
                    controller: roomPriceController,
                    labelText: 'سعر الساعة',
                    hintText: '50 ج.م',
                    keyboardType: TextInputType.number,
                  ),
                  verticalSpace(40),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: isUpdating ? 'جاري الحفظ...' : 'حفظ التغييرات',
                      backgroundColor: ColorPalette.primary,
                      onPressed: () {
                        if (isUpdating || isDeleting) return;

                        final name = roomNameController.text.trim();
                        final rate =
                            double.tryParse(roomPriceController.text) ?? 0.0;

                        if (name.isEmpty || rate <= 0) return;

                        context.read<RoomSettingsCubit>().updateRoom(
                          id: widget.room.id,
                          name: name,
                          hourlyRate: rate,
                          createdAt: widget.room.createdAt,
                        );
                      },
                    ),
                  ),
                  verticalSpace(16),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: isDeleting ? 'جاري الحذف...' : 'حذف الغرفة',
                      backgroundColor: ColorPalette.statusDanger,
                      onPressed: () {
                        if (isUpdating || isDeleting) return;

                        context.read<RoomSettingsCubit>().deleteRoom(
                          id: widget.room.id,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
