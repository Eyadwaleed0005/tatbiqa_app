import 'package:flutter/material.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/widgets/app_custom_dialog.dart';
import 'package:tatbiqa/core/widgets/custom_text_form_field.dart';

class AddEditProductDialog extends StatefulWidget {
  const AddEditProductDialog({
    super.key,
    this.initialName,
    this.initialPrice,
  });

  final String? initialName;
  final String? initialPrice;

  static void show(BuildContext context, {String? initialName, String? initialPrice}) {
    showDialog(
      context: context,
      builder: (context) => AddEditProductDialog(
        initialName: initialName,
        initialPrice: initialPrice,
      ),
    );
  }

  @override
  State<AddEditProductDialog> createState() => _AddEditProductDialogState();
}

class _AddEditProductDialogState extends State<AddEditProductDialog> {
  late final TextEditingController _productNameController;
  late final TextEditingController _productPriceController;

  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController(text: widget.initialName ?? '');
    _productPriceController = TextEditingController(text: widget.initialPrice ?? '');
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppCustomDialog(
      title: 'إضافة أو تعديل منتج',
      subtitle: 'أدخل اسم المنتج وسعر القطعة',
      confirmButtonText: 'حفظ المنتج',
      onConfirm: () {

        
    
        Navigator.pop(context);
      },
      contentChild: Column(
        children: [
          CustomTextFormField(
            controller: _productNameController,
            labelText: 'اسم المنتج',
            hintText: 'مثال: شاي',
            isRequired: true,
          ),
          verticalSpace(16),
          CustomTextFormField(
            controller: _productPriceController,
            labelText: 'السعر',
            hintText: '10 ج.م',
            keyboardType: TextInputType.number,
            isRequired: true,
          ),
        ],
      ), 
    );
  }
}