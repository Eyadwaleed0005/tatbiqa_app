import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/products/domain/entity/products_entity.dart';

abstract class ProductsRepo {
  Future<Either<Failure, ProductEntity>> addProduct({   required String name,
    required double price,});
  Future<Either<Failure, ProductEntity>> updateProduct({ required int id,required String name,
    required double price,
    required bool isAvailable,});
  Future <Either<Failure, void>> deleteProduct({required int id});
  Future<Either<Failure, List<ProductEntity>>> getProducts();

}
