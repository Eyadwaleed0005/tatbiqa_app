import 'package:hive/hive.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';

part 'session_product_model.g.dart';

@HiveType(typeId: 4) 
class SessionProductModel extends SessionProductEntity {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final int sessionId;
  @HiveField(2)
  final int productId;
  @HiveField(3)
  final String productName;
  @HiveField(4)
  final double unitPrice;
  @HiveField(5)
  final int quantity;
  @HiveField(6)
  final double totalPrice;
  @HiveField(7)
  final DateTime createdAt;

   const SessionProductModel({
    this.id,
    required this.sessionId,
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
    required this.createdAt,
  }) : super(
          id: id,
          sessionId: sessionId,
          productId: productId,
          productName: productName,
          unitPrice: unitPrice,
          quantity: quantity,
          totalPrice: totalPrice,
          createdAt: createdAt,
        );

  factory SessionProductModel.fromEntity(SessionProductEntity e) =>
      SessionProductModel(
        id: e.id,
        sessionId: e.sessionId,
        productId: e.productId,
        productName: e.productName,
        unitPrice: e.unitPrice,
        quantity: e.quantity,
        totalPrice: e.totalPrice,
        createdAt: e.createdAt,
      );
}