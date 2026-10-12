import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/app/dependency_injection/service_locator.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/widgets/app_custom_dialog.dart';
import 'package:tatbiqa/core/widgets/app_toast.dart';
import 'package:tatbiqa/core/widgets/custom_text_form_field.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/add_room_cubit.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/add_room_state.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/rooms_cubit.dart';

class AddRoomDialog extends StatefulWidget {
  const AddRoomDialog({super.key});

  static void show(BuildContext context) {
    final roomsCubit = context.read<RoomsCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) => MultiBlocProvider(
        providers: [
          BlocProvider<AddRoomCubit>(
            create: (context) => getIt<AddRoomCubit>(),
          ),
          BlocProvider<RoomsCubit>.value(value: roomsCubit),
        ],
        child: const AddRoomDialog(),
      ),
    );
  }

  @override
  State<AddRoomDialog> createState() => _AddRoomDialogState();
}

class _AddRoomDialogState extends State<AddRoomDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _roomNameController;
  late final TextEditingController _roomPriceController;

  @override
  void initState() {
    super.initState();
    _roomNameController = TextEditingController();
    _roomPriceController = TextEditingController();
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    _roomPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRoomCubit, AddRoomState>(
      listener: (context, state) {
        if (state is AddRoomSuccess) {
          AppToast.show(context, 'تم انشاء الغرفة بنجاح');
          context.read<RoomsCubit>().getRooms();
          Navigator.of(context).pop();
        } else if (state is AddRoomFailure) {
          AppToast.show(context, state.errMessage);

          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return AppCustomDialog(
          title: 'إضافة غرفة جديدة',
          subtitle: 'أدخل اسم الغرفة وسعر الساعة',
          confirmButtonText: 'إنشاء الغرفة',
          titleTextAlign: TextAlign.end,
          onConfirm: () {
            if (_formKey.currentState!.validate()) {
              final name = _roomNameController.text.trim();
              final price = double.parse(_roomPriceController.text);

              context.read<AddRoomCubit>().addRoom(
                name: name,
                hourlyRate: price,
              );
            }
          },
          contentChild: Form(
            key: _formKey,
            child: Column(
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
          ),
        );
      },
    );
  }
}
