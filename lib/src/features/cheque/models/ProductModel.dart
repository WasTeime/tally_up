class ProductModel {
  final String name;
  final double price;
  final int quantity;

  ProductModel({
    required this.name,
    required this.quantity,
    required this.price,
  });

  double get getFinalPrice => quantity * price;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}
