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
  final TextEditingController _storeNameController = TextEditingController(
    text: "ELHAMOUL CITY",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "ghorab@gmail.com",
  );
  final TextEditingController _ownerNameController = TextEditingController(
    text: "Eyad waleed",
  );
  final TextEditingController _phoneController = TextEditingController(
    text: "010********",
  );

  @override
  void initState() {
    super.initState();
    _storeNameController;
    _emailController;
    _ownerNameController;
    _phoneController;
  }

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
            hintText: "أدخل اسم المحل",
          ),
          verticalSpace(12),

          CustomTextFormField(
            controller: _emailController,
            labelText: "البريد الالكتروني",
            hintText: "أدخل البريد الالكتروني",
            keyboardType: TextInputType.emailAddress,
          ),
          verticalSpace(12),

          CustomTextFormField(
            controller: _ownerNameController,
            labelText: "اسم صاحب المحل",
            hintText: "أدخل اسم صاحب المحل",
          ),
          verticalSpace(12),

          CustomTextFormField(
            controller: _phoneController,
            labelText: "رقم التليفون",
            hintText: "أدخل رقم التليفون",
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
