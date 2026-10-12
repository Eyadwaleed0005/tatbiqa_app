import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/products/data/data_source/products_hive_local_data_source.dart';
import 'package:tatbiqa/feature/products/domain/entity/products_entity.dart';
import 'package:tatbiqa/feature/products/domain/repo/products_repo.dart';

class ProductsRepoImpl implements ProductsRepo {
  final ProductsHiveLocalDataSource localDataSource;

  ProductsRepoImpl({required this.localDataSource});
  @override
  Future<Either<Failure, ProductEntity>> addProduct({
    required String name,
    required double price,
  }) async {
    try {
      final product = await localDataSource.addProducts(
        name: name,
        price: price,
      );
      return right(product);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct({required int id}) async {
    try {
      await localDataSource.deleteProduct(id: id);
      return right(null);
    } catch (e) {
   return   left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final product = await localDataSource.getProducts();
      return right(product);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct({
    required int id,
    required String name,
    required double price,
    required bool isAvailable,
  }) async {
    try {
      final product = await localDataSource.updateProduct(
        id: id,
        price: price,
        name: name,
        isAvailable: isAvailable,
      );
      return right(product);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }
}
