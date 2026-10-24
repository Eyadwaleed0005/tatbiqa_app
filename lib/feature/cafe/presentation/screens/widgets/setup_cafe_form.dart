import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tatbiqa/app/routes/screen_routes/route_names.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/core/hive/hive_keys.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_operation_result_dialog.dart';
import 'package:tatbiqa/core/widgets/custom_text_form_field.dart';
import 'package:tatbiqa/feature/cafe/data/models/cafe_model.dart';
import 'package:tatbiqa/feature/cafe/presentation/cubit/cafe_cubit.dart';
import 'package:tatbiqa/feature/cafe/presentation/cubit/cafe_state.dart';
import 'package:tatbiqa/feature/subscription/presentation/cubit/subscription_cubit.dart';
import 'package:tatbiqa/feature/subscription/presentation/cubit/subscription_state.dart';

class SetupCafeForm extends StatefulWidget {
  const SetupCafeForm({super.key});

  @override
  State<SetupCafeForm> createState() => _SetupCafeFormState();
}

class _SetupCafeFormState extends State<SetupCafeForm> {
  final TextEditingController cafeNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cafeNameController.dispose();
    emailController.dispose();
    ownerNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!formKey.currentState!.validate()) return;

    context.read<CafeCubit>().saveCafeInfo(
      cafeName: cafeNameController.text.trim(),
      email: emailController.text.trim(),
      ownerName: ownerNameController.text.trim(),
      phone: phoneController.text.trim(),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => CustomOperationResultDialog(
        type: CustomOperationResultType.success,
        title: 'تم الحفظ بنجاح',
        message: 'تم حفظ بيانات المحل بنجاح',
        actionText: 'متابعة',
        onActionPressed: () {
          Navigator.of(dialogContext).pop();
          Navigator.pushReplacementNamed(context, RouteNames.main);
        },
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (dialogContext) => CustomOperationResultDialog(
        type: CustomOperationResultType.failure,
        title: 'حدث خطأ',
        message: message,
        actionText: 'حاول مرة أخرى',
        secondaryActionText: 'إغلاق',
        onActionPressed: () {
          Navigator.of(dialogContext).pop();
          _submit();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CafeCubit, CafeState>(
          listenWhen: (previous, current) =>
              current is SaveCafeDataSuccess || current is SaveCafeDataError,
          listener: (context, state) {
            if (state is SaveCafeDataSuccess) {
              final cafe = Hive.box<CafeModel>(HiveBoxes.cafe)
                  .get(HiveKeys.kCafeId);

              if (cafe != null) {
                context.read<SubscriptionCubit>().checkStatus(cafe);
              }
            } else if (state is SaveCafeDataError) {
              _showErrorDialog(state.message);
            }
          },
        ),

        BlocListener<SubscriptionCubit, SubscriptionState>(
          listener: (context, state) {
            if (state is SubscriptionActiveState) {
              _showSuccessDialog();
            } else if (state is SubscriptionExpiredState) {
              Navigator.pushReplacementNamed(
                context,
                RouteNames.subscription,
                arguments: state,
              );
            } else if (state is SubscriptionErrorState) {
              _showErrorDialog('تأكد من الاتصال بالإنترنت وحاول مرة أخرى');
            }
          },
        ),
      ],
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: cafeNameController,
              labelText: 'اسم المحل',
              hintText: 'مثال: ELHAMOUL CITY',
              isRequired: true,
            ),
            verticalSpace(16),
            CustomTextFormField(
              controller: emailController,
              labelText: 'البريد الالكتروني',
              hintText: 'مثال: ghorab@gmail.com',
              keyboardType: TextInputType.emailAddress,
              isRequired: true,
            ),
            verticalSpace(16),
            CustomTextFormField(
              controller: ownerNameController,
              labelText: 'اسم صاحب المحل',
              hintText: 'مثال: Eyad waleed',
              isRequired: true,
            ),
            verticalSpace(16),
            CustomTextFormField(
              controller: phoneController,
              labelText: 'رقم الهاتف',
              hintText: 'مثال: 010*********',
              keyboardType: TextInputType.phone,
              isRequired: true,
            ),
            verticalSpace(24),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
              
                text: 'حفظ',
                onPressed: _submit,
                textStyle: AppTextStyle.fontReadexPro14MediumBlackColor,
              ),
            ),
            verticalSpace(12),
          ],
        ),
      ),
    );
  }
}
