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




// class Products {
//   final String productName;
//   final String brand;
//   final String category;
//   final String productType;
//   final String description;
//   final int quantity;
//   final double price;
//   final List images;
//   final String? id;
//   Products.fromJson( json)
//       : this(
//           productName: json['name']! as String,
//           brand: json['brand']! as String,
//           category: json['category']! as String,
//           productType: json["productType"] as String,
//           description: json["description"] as String,
//           quantity: json['quantity']! as int,
//           price: json['price']! as double,
//           images: json['images']! as List,
//           id: json['id']! as String,
//         );

//   Products({
//     required this.productName,
//     required this.brand,
//     required this.category,
//     required this.productType,
//     required this.description,
//     required this.quantity,
//     required this.price,
//     required this.images,
//     required this.id,
//   });
// }







// class Products {
//   final String productName;
//   final String subname;
//   final String category;
//   final int quantity;
//   final int price;
//   final String color;
//   final String description;
//   final List? imageList;
//   final String? id;
//   Products.fromJson(Map<String, Object?> json)
//       : this(
//           productName: json['name']! as String,
//           subname: json['subname']! as String,
//           category: json['category']! as String,
//           quantity: json['quantity']! as int,
//           price: json['price']! as int,
//           color: json['color']! as String,
//           description: json['description']! as String,
//           imageList: json['image']! as List,
//           id: json['id']! as String,
//         );
//   Products({
//     required this.productName,
//     required this.subname,
//     required this.category,
//     required this.quantity,
//     required this.price,
//     required this.color,
//     required this.description,
//     this.imageList,
//     this.id,
//   });
// }
