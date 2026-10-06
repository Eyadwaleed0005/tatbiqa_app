
import 'package:tatbiqa/feature/products/data/models/products_model.dart';

abstract class ProductsHiveLocalDataSource {
  Future<ProductsModel> addProducts({
    required String name,
    required double price,
  });
  Future<List<ProductsModel>> getProducts();
  Future<ProductsModel> updateProduct({
    required int id,
    required String name,
    required double price,
    required bool isAvailable,
  });

  Future< void> deleteProduct({required int id});
}
