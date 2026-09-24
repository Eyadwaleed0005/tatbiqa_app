import 'package:flutter/material.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_text_form_field.dart';

class SetupCafeForm extends StatefulWidget {
  const new({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Form(
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
          ),
          verticalSpace(16),

          CustomTextFormField(
            controller: ownerNameController,
            labelText: 'اسم صاحب المحل',
            hintText: 'مثال: Eyad waleed',
          ),
          verticalSpace(16),

          CustomTextFormField(
            controller: phoneController,
            labelText: 'رقم الهاتف',
            hintText: 'مثال: 010*********',
            keyboardType: TextInputType.phone,
          ),
          verticalSpace(24),

          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              text: 'حفظ',
              onPressed: () {
                if (formKey.currentState!.validate()) {}
              },
              textStyle: AppTextStyle.fontReadexPro14MediumBlackColor,
            ),
          ),
          verticalSpace(12),
        ],
      ),
    );
  }
}
