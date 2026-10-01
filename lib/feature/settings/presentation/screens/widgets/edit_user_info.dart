import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';
import 'package:tatbiqa/core/widgets/custom_app_button.dart';
import 'package:tatbiqa/core/widgets/custom_app_card.dart';
import 'package:tatbiqa/core/widgets/custom_text_form_field.dart';
import 'package:tatbiqa/feature/cafe/domain/entity/cafe_entity.dart';
import 'package:tatbiqa/feature/cafe/presentation/cubit/cafe_cubit.dart';
import 'package:tatbiqa/feature/cafe/presentation/cubit/cafe_state.dart';

class EditUserInfo extends StatefulWidget {
  const EditUserInfo({super.key});

  @override
  State<EditUserInfo> createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  final _storeNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isEditing = false;
  CafeEntity? _currentCafe;

  void _fillFields(CafeEntity cafe) {
    _currentCafe = cafe;
    _storeNameController.text = cafe.cafeName;
    _emailController.text = cafe.email;
    _ownerNameController.text = cafe.ownerName;
    _phoneController.text = cafe.phone;
  }

  void _toggleEditing() {
    setState(() {
      if (_isEditing && _currentCafe != null) _fillFields(_currentCafe!);
      _isEditing = !_isEditing;
    });
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
    return BlocConsumer<CafeCubit, CafeState>(
      listener: (context, state) {
        if (state is GetDataCafeSuccess) {
          _fillFields(state.cafeEntity);
        } else if (state is SaveCafeDataSuccess) {
          _fillFields(state.cafeEntity);
          setState(() => _isEditing = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("تم حفظ بيانات المحل بنجاح"),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is SaveCafeDataError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: ColorPalette.statusDanger,
            ),
          );
        }
      },
      builder: (context, state) {
        final isSaving = state is SaveCafeDataLoading;
        final isLoadingData = state is GetDataCafeLoading;

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
                    onPressed: (isSaving || isLoadingData)
                        ? null
                        : _toggleEditing,
                  ),
                  Text(
                    "تعديل بيانات المحل",
                    style: AppTextStyle.fontCairo18SemiBoldWhiteColor,
                  ),
                ],
              ),
              verticalSpace(16),
              if (isLoadingData)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                )
              else ...[
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
                      text: isSaving ? "جاري الحفظ..." : "حفظ",
                      onPressed: () {
                        if (isSaving) return;
                        context.read<CafeCubit>().saveCafeInfo(
                          cafeName: _storeNameController.text.trim(),
                          email: _emailController.text.trim(),
                          ownerName: _ownerNameController.text.trim(),
                          phone: _phoneController.text.trim(),
                        );
                      },
                    ),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}
