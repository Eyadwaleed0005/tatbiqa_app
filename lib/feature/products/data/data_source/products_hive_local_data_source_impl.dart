
import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/core/hive/local_database_service.dart';
import 'package:tatbiqa/feature/products/data/data_source/products_hive_local_data_source.dart';
import 'package:tatbiqa/feature/products/data/models/products_model.dart';

class ProductsHiveLocalDataSourceImpl implements ProductsHiveLocalDataSource {
  final LocalDatabaseService localDatabaseService;

  ProductsHiveLocalDataSourceImpl({required this.localDatabaseService});
  @override
  Future<ProductsModel> addProducts({
    required String name,
    required double price,
  }) async {
    final products = await getProducts();
    final exits = products.any(
      (p) => p.name.toLowerCase().trim() == name.toLowerCase().trim(),
    );
    if (exits) {
      throw Exception('اسم المنتج موجود بالفعل');
    }
    final product = ProductsModel(
      id: DateTime.now().millisecondsSinceEpoch % 2147483647,
      name: name,
      price: price,
      isAvailable: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await localDatabaseService.putData(
      boxName: HiveBoxes.products,
      key: product.id,
      value: product,
    );
    return product;
  }

  @override
  Future<List<ProductsModel>> getProducts() async {
    return await localDatabaseService.getAll(boxName: HiveBoxes.products);
  }
@override
  Future<ProductsModel> updateProduct({
    required int id,
    required String name,
    required double price,
    required bool isAvailable,
  }) async {
    final updatedProduct = ProductsModel(
      id: id, 
      name: name,
      price: price,
      isAvailable: isAvailable,
      createdAt: DateTime.now(), 
      updatedAt: DateTime.now(), 
    );

    await localDatabaseService.putData(
      boxName: HiveBoxes.products,
      key: id,
      value: updatedProduct,
    );

    return updatedProduct;
  }

  @override
  Future<void> deleteProduct({required int id}) async{
  
    return await localDatabaseService.deleteData<ProductsModel>(boxName: HiveBoxes.products, key: id);


  }
}
