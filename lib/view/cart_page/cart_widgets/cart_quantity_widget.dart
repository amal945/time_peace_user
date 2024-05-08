import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartQuantityWidget extends StatefulWidget {
  final String productId;
  final int currentQuantity;
  final int totalQuantiy;

  const CartQuantityWidget({
    Key? key,
    required this.productId,
    required this.currentQuantity,
    required this.totalQuantiy,
  }) : super(key: key);

  @override
  _CartQuantityWidgetState createState() => _CartQuantityWidgetState();
}

class _CartQuantityWidgetState extends State<CartQuantityWidget> {
  int _quantity = 1;
  int stockQuantity = 5;

  @override
  void initState() {
    super.initState();
    if (widget.totalQuantiy < 5) {
      stockQuantity = widget.totalQuantiy;
    }
    _quantity = widget.currentQuantity;
  }

  void _increaseQuantity() {
    setState(() {
      if (_quantity < stockQuantity) {
        _quantity++;
        _updateQuantityInCart();
      } else {
        // Show a snackbar or any other message indicating the limit has been reached
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Maximum quantity reached'),
          ),
        );
      }
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        _updateQuantityInCart();
      }
    });
  }

  void _updateQuantityInCart() {
    String email = FirebaseAuth.instance.currentUser!.email!;
    try {
      FirebaseFirestore.instance
          .collection('cart')
          .where('productId', isEqualTo: widget.productId)
          .where('email', isEqualTo: email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.first.reference
              .update({'quantity': _quantity}).then(
            (value) {
              print('Quantity updated successfully');
            },
          ).catchError((error) {
            print('Failed to update quantity in cart: $error');
          });
        } else {
          print('Product not found in cart');
        }
      });
    } catch (e) {
      print('Error updating quantity in cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 3.7,
      height: size.height / 18,
      decoration: BoxDecoration(
        color: Colors.yellow,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(18)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.yellow,
              child: InkWell(
                onTap: _decreaseQuantity,
                splashColor: const Color.fromARGB(255, 211, 198, 96),
                child: Container(child: const Icon(Icons.remove)),
              ),
            ),
            Text(
              _quantity.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Material(
              color: Colors.yellow,
              child: InkWell(
                onTap: _increaseQuantity,
                splashColor: const Color.fromARGB(255, 211, 198, 96),
                child: Container(child: const Icon(Icons.add)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
