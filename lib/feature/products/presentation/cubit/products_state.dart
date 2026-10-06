part of 'products_cubit.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final List<ProductEntity> productEntity;

  const ProductsSuccess({required this.productEntity});
   List<ProductEntity> get available =>
      productEntity.where((p) => p.isAvailable).toList();

  @override
  List<Object> get props => [productEntity];
}

final class ProductsFailure extends ProductsState {
  final String error;

  const ProductsFailure({required this.error});
  @override
  List<Object> get props => [error];
}

final class AddProductsInitial extends ProductsState {}

final class AddProductsLoading extends ProductsState {}

final class AddProductsSuccess extends ProductsState {
  final ProductEntity products;

  const AddProductsSuccess({required this.products});
  @override
  List<Object> get props => [products];
}

final class AddProductsFailure extends ProductsState {
  final String error;

  const AddProductsFailure({required this.error});
  @override
  List<Object> get props => [error];
}

final class UpdateProductsInitial extends ProductsState {}

final class UpdateProductsLoading extends ProductsState {}

final class UpdateProductsSuccess extends ProductsState {
  final ProductEntity products;

  const UpdateProductsSuccess({required this.products});
  @override
  List<Object> get props => [products];
}

final class UpdateProductsFailure extends ProductsState {
  final String error;

  const UpdateProductsFailure({required this.error});
  @override
  List<Object> get props => [error];
}

final class DeleteProductsInitial extends ProductsState {}

final class DeleteProductsLoading extends ProductsState {}

final class DeleteProductsSuccess extends ProductsState {
  final String message;

  const DeleteProductsSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

final class DeleteProductsFailure extends ProductsState {
  final String error;

  const DeleteProductsFailure({required this.error});
  @override
  List<Object> get props => [error];
}
