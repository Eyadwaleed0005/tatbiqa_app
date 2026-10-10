import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/products/domain/entity/products_entity.dart';
import 'package:tatbiqa/feature/products/domain/repo/products_repo.dart';

class ProductsUseCase {
  final ProductsRepo repo;

  ProductsUseCase({required this.repo});
  Future<Either<Failure, ProductEntity>> addProducts({
    required String name,
    required double price,
  }) async {
    return await repo.addProduct(name: name, price: price);
  }

  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    return await repo.getProducts();
  }
    Future<Either<Failure, ProductEntity>> updateProduct({ required int id,required String name,
    required double price,
    required bool isAvailable,})async{
    return await repo.updateProduct(id: id, name: name, price: price, isAvailable: isAvailable);

    }

   Future <Either<Failure, void>>deleteProduct({required int id})async{
    return await repo.deleteProduct(id: id);

   }
  
}
