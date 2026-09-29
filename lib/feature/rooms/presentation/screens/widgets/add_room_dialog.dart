import 'package:flutter/material.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/widgets/app_custom_dialog.dart';
import 'package:tatbiqa/core/widgets/custom_text_form_field.dart';

class AddRoomDialog extends StatefulWidget {
  const AddRoomDialog({super.key, this.initialRoomName, this.initialRoomPrice});

  final String? initialRoomName;
  final String? initialRoomPrice;

  static void show(
    BuildContext context, {
    String? initialRoomName,
    String? initialRoomPrice,
  }) {
    showDialog(
      context: context,
      builder: (context) => AddRoomDialog(
        initialRoomName: initialRoomName,
        initialRoomPrice: initialRoomPrice,
      ),
    );
  }

  @override
  State<AddRoomDialog> createState() => _AddRoomDialogState();
}

class _AddRoomDialogState extends State<AddRoomDialog> {
  late final TextEditingController _roomNameController;
  late final TextEditingController _roomPriceController;

  @override
  void initState() {
    super.initState();
    _roomNameController = TextEditingController(
      text: widget.initialRoomName ?? '',
    );
    _roomPriceController = TextEditingController(
      text: widget.initialRoomPrice ?? '',
    );
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    _roomPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppCustomDialog(
      title: 'إضافة غرفة جديدة',
      subtitle: 'أدخل اسم الغرفة وسعر الساعة',
      confirmButtonText: 'إنشاء الغرفة',
      titleTextAlign: TextAlign.end,
      onConfirm: () {
        Navigator.pop(context);
      },
      contentChild: Column(
        children: [
          CustomTextFormField(
            controller: _roomNameController,
            labelText: 'اسم الغرفة',
            hintText: 'مثال: غرفة 06',
            isRequired: true,
          ),
          verticalSpace(16),
          CustomTextFormField(
            controller: _roomPriceController,
            labelText: 'سعر الساعة',
            hintText: '50 ج.م',
            keyboardType: TextInputType.number,
            isRequired: true,
          ),
        ],
      ),
    );
  }
}
