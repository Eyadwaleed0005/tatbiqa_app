class DrinkItem {
  final String name;
  final int price;
  int quantity;
  final bool isAvailable;

  DrinkItem({
    required this.name,
    required this.price,
    this.quantity = 0,
    this.isAvailable = true,
  });
}