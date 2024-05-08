class Product {
  final String id;
  final String productName;
  final String brand;
  final String category;
  final String productType;
  final String description;
  final int quantity;
  final double price;
  final String image;
  final String color;

  Product({
    required this.id,
    required this.productName,
    required this.brand,
    required this.category,
    required this.productType,
    required this.description,
    required this.quantity,
    required this.price,
    required this.image,
    required this.color,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
        id: id,
        productName: map['productName'],
        brand: map['brand'],
        category: map['category'],
        productType: map['productType'],
        description: map['description'],
        quantity: map['quantity'],
        price: map['price'],
        image: map['image'],
        color: map['color']);
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'brand': brand,
      'category': category,
      'productType': productType,
      'description': description,
      'quantity': quantity,
      'price': price,
      'image': image,
      'color': color,
    };
  }
}


