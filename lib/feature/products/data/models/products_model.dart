import 'package:hive/hive.dart';
import 'package:tatbiqa/feature/products/domain/entity/products_entity.dart';
part 'products_model.g.dart';

@HiveType(typeId: 2)
class ProductsModel extends ProductEntity{
 @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final double price;
  @override
  @HiveField(3)
  final bool isAvailable;
  @override
  @HiveField(4)
  final DateTime createdAt;
  @override
  @HiveField(5)
  final DateTime updatedAt;

  ProductsModel({required this.id, required this.name, required this.price, required this.isAvailable, required this.createdAt, required this.updatedAt}):super( 
    id: id,
          name: name,
        price  : price,
        isAvailable: isAvailable,
          createdAt: createdAt,
          updatedAt: updatedAt,);

}