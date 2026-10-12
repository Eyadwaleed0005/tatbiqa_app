class SessionProductEntity {
  final int? id;
  final int sessionId;
  final int productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double totalPrice;
  final DateTime createdAt;

  const SessionProductEntity({
    this.id,
    required this.sessionId,
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
    required this.createdAt,
  });
}