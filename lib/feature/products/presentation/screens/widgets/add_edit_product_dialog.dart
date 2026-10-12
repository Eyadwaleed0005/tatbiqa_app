import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/widgets/app_custom_dialog.dart';
import 'package:tatbiqa/core/widgets/custom_operation_result_dialog.dart';
import 'package:tatbiqa/core/widgets/custom_text_form_field.dart';
import 'package:tatbiqa/feature/products/domain/entity/products_entity.dart';
import 'package:tatbiqa/feature/products/presentation/cubit/products_cubit.dart';

class AddEditProductDialog extends StatefulWidget {
  const AddEditProductDialog({super.key, this.product});

  final ProductEntity? product;

  static void show(BuildContext context, {ProductEntity? product}) {
    final productsCubit = context.read<ProductsCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: productsCubit,
        child: AddEditProductDialog(product: product),
      ),
    );
  }

  @override
  State<AddEditProductDialog> createState() => _AddEditProductDialogState();
}

class _AddEditProductDialogState extends State<AddEditProductDialog> {
  late final TextEditingController _productNameController;
  late final TextEditingController _productPriceController;

  bool get isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController(
      text: widget.product?.name ?? '',
    );
    _productPriceController = TextEditingController(
      text: widget.product?.price != null
          ? widget.product!.price.toString()
          : '',
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is AddProductsSuccess || state is UpdateProductsSuccess) {
          context.read<ProductsCubit>().fetchProdcts();

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => CustomOperationResultDialog(
              type: CustomOperationResultType.success,
              title: isEditing
                  ? 'تم تعديل المنتج بنجاح'
                  : 'تم إنشاء المنتج بنجاح',
              message: isEditing
                  ? 'تم تعديل المنتج بنجاح'
                  : 'تم إنشاء المنتج بنجاح',
              actionText: 'متابعة',
              onActionPressed: () {
                Navigator.of(dialogContext).pop(); 
                Navigator.of(context).pop();
              },
            ),
          );
        } else if (state is AddProductsFailure ||
            state is UpdateProductsFailure) {
          final errorMessage = state is AddProductsFailure
              ? state.error
              : (state is UpdateProductsFailure ? state.error : 'حدث خطأ ما');

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => CustomOperationResultDialog(
              type: CustomOperationResultType.failure,
              title: 'حدث خطأ',
              message: errorMessage,
              actionText: 'متابعة',
              onActionPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading =
            state is AddProductsLoading || state is UpdateProductsLoading;

        return AppCustomDialog(
          title: isEditing ? 'تعديل المنتج' : 'إضافة منتج',
          subtitle: 'أدخل اسم المنتج وسعر القطعة',
          confirmButtonText: isLoading ? 'جاري الحفظ...' : 'حفظ المنتج',
          onConfirm: () {
            final name = _productNameController.text.trim();
            final price =
                double.tryParse(_productPriceController.text.trim()) ?? 0.0;

            if (name.isNotEmpty && price > 0) {
              if (isEditing) {
                context.read<ProductsCubit>().updateProduct(
                  id: widget.product!.id,
                  name: name,
                  price: price,
                  isAvailable: widget.product!.isAvailable,
                );
              } else {
                context.read<ProductsCubit>().addProdcts(
                  name: name,
                  price: price,
                );
              }
            }
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
      },
    );
  }
}
