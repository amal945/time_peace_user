import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  final String email;
  final double price;
  final String productId;
  final String productName;
  final int quantity;
  final String id;

  Cart({
    required this.email,
    required this.price,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.id,
  });

  factory Cart.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Cart(
      email: data['email'],
      price: data['price'],
      productId: data['productId'],
      productName: data['productName'],
      quantity: data['quantity'],
      id: snapshot.id,
    );
  }
}
