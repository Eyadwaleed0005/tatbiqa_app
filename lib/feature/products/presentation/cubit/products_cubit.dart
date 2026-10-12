import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tatbiqa/feature/products/domain/entity/products_entity.dart';
import 'package:tatbiqa/feature/products/domain/usecase/products_usecase.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsUseCase products;

  ProductsCubit({required this.products}) : super(ProductsInitial());
  Future<void> addProdcts({required String name, required double price}) async {
    emit(AddProductsLoading());
    final product = await products.addProducts(name: name, price: price);
    product.fold(
      (failure) => emit(AddProductsFailure(error: failure.message)),
      (products) => emit(AddProductsSuccess(products: products)),
    );
  }

  Future<void> fetchProdcts() async {
    emit(ProductsLoading());
    final product = await products.getProducts();
    product.fold(
      (failure) => emit(ProductsFailure(error: failure.message)),
      (products) =>
          emit(ProductsSuccess(productEntity: products.reversed.toList())),
    );
  }

  Future<void> updateProduct({
    required int id,
    required String name,
    required double price,
    required bool isAvailable,
  }) async {
    emit(UpdateProductsLoading());
    final product = await products.updateProduct(
      id: id,
      name: name,
      price: price,
      isAvailable: isAvailable,
    );
    product.fold(
      (failure) => emit(UpdateProductsFailure(error: failure.message)),
      (products) => emit(UpdateProductsSuccess(products: products)),
    );
  }

  Future<void> deleteProduct({required int id}) async {
    emit(DeleteProductsLoading());
    final product = await products.deleteProduct(id: id);
    product.fold(
      (failure) => emit(DeleteProductsFailure(error: failure.message)),
      (products) => emit(DeleteProductsSuccess(message: 'تم حذف المنتج بنجاح ')),
    );
  }
}
