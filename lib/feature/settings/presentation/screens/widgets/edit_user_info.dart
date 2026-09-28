import 'package:flutter/material.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/core/widgets/custom_text_form_field.dart';

class EditUserInfo extends StatefulWidget {
  const EditUserInfo({super.key});

  @override
  State<EditUserInfo> createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isEditing = false;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  _isEditing ? Icons.close : Icons.edit,
                  color: ColorPalette.whiteColor,
                ),
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
              ),
              Text(
                "تعديل بيانات المحل",
                style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
              ),
            ],
          ),
          verticalSpace(16),

          CustomTextFormField(
            controller: _storeNameController,
            labelText: "اسم المحل",
            hintText: "ELHAMOUL CITY",
            enabled: _isEditing,
          ),
          verticalSpace(12),

          CustomTextFormField(
            controller: _emailController,
            labelText: "البريد الالكتروني",
            hintText: "ghorab@gmail.com",
            keyboardType: TextInputType.emailAddress,
            enabled: _isEditing,
          ),
          verticalSpace(12),

          CustomTextFormField(
            controller: _ownerNameController,
            labelText: "اسم صاحب المحل",
            hintText: "Eyad waleed",
            enabled: _isEditing,
          ),
          verticalSpace(12),

          CustomTextFormField(
            controller: _phoneController,
            labelText: "رقم التليفون",
            hintText: "010********",
            keyboardType: TextInputType.phone,
            enabled: _isEditing,
          ),
          verticalSpace(20),

          if (_isEditing)
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: "حفظ",
                onPressed: () {
                  setState(() {
                    _isEditing = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
