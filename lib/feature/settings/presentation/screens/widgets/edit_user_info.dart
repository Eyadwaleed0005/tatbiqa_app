import 'package:flutter/material.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/core/widgets/custom_outlined_button.dart';
import 'package:tatbiqa/core/widgets/custom_text_form_field.dart';

class EditUserInfo extends StatefulWidget {
  const new({super.key});

  @override
  State<EditUserInfo> createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _storeNameController.dispose();
    _emailController.dispose();
    _ownerNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "تعديل اسم المحل",
            style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
          ),
          verticalSpace(16),

          CustomTextFormField(
            controller: _storeNameController,
            labelText: "اسم المحل",
            hintText: "ELHAMOUL CITY",
          ),
          verticalSpace(12),

          CustomTextFormField(
            controller: _emailController,
            labelText: "البريد الالكتروني",
            hintText: "ghorab@gmail.com",
            keyboardType: TextInputType.emailAddress,
          ),
          verticalSpace(12),

          CustomTextFormField(
            controller: _ownerNameController,
            labelText: "اسم صاحب المحل",
            hintText: "Eyad waleed",
          ),
          verticalSpace(12),

          CustomTextFormField(
            controller: _phoneController,
            labelText: "رقم التليفون",
            hintText: "010********",
            keyboardType: TextInputType.phone,
          ),
          verticalSpace(20),

          SizedBox(
            width: double.infinity,
            child: CustomOutlinedButton(text: "حفظ", onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
