// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'productmodel.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

late List<String> _wishlistProducts = [];

List<String> get wishlistProducts => _wishlistProducts;

Future<List<String>> getWishlistProducts() async {
  String? userEmail = (FirebaseAuth.instance.currentUser)?.email;
  if (userEmail != null) {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('wishlist')
        .where('email', isEqualTo: userEmail)
        .get();
    _wishlistProducts =
        querySnapshot.docs.map((doc) => doc['productId'] as String).toList();
    return _wishlistProducts;
  }
  return [];
}

bool isProductInWishlist(String productId) {
  return _wishlistProducts.contains(productId);
}

Future<void> addToWishlist(String productId, BuildContext context) async {
  try {
    // Get the current user's email
    String? userEmail = _auth.currentUser!.email;

    // Check if the product is already in the wishlist
    QuerySnapshot snapshot = await _db
        .collection('wishlist')
        .where('productId', isEqualTo: productId)
        .where('email', isEqualTo: userEmail)
        .get();

    // If product is already in wishlist and user unlikes it, remove it from wishlist
    if (snapshot.docs.isNotEmpty) {
      await _db.runTransaction((transaction) async {
        snapshot.docs.forEach((doc) {
          transaction.delete(doc.reference);
        });
      });
      _wishlistProducts.remove(productId);
      getWishlistProducts();

      showSuccessSnackBar("Removed from WishList", context);
      return;
    }

    // If product is not in wishlist and user likes it, add it to wishlist
    if (snapshot.docs.isEmpty) {
      await _db.collection('wishlist').add({
        'productId': productId,
        'email': userEmail,
      });
    }

    getWishlistProducts();

    showSuccessSnackBar("Added to WishList", context);
  } catch (e) {
    print('Error adding/removing from wishlist: $e');
  }
}

Stream<List<Product>> getWishlistStream() {
  return FirebaseFirestore.instance
      .collection('products')
      .where(FieldPath.documentId, whereIn: wishlistProducts)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) =>
              Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList());
}

Future<DocumentSnapshot> getProduct(String productId) async {
  return await FirebaseFirestore.instance
      .collection('products')
      .doc(productId)
      .get();
}

Future<void> removeFromWishlist(String productId, BuildContext context) async {
  try {
    String? userEmail = _auth.currentUser!.email;

    QuerySnapshot snapshot = await _db
        .collection('wishlist')
        .where('productId', isEqualTo: productId)
        .where('email', isEqualTo: userEmail)
        .get();

    // If product is in the wishlist, remove it
    if (snapshot.docs.isNotEmpty) {
      await _db.runTransaction((transaction) async {
        snapshot.docs.forEach((doc) {
          transaction.delete(doc.reference);
        });
      });

      _wishlistProducts.remove(productId);
    }
  } catch (e) {
    showFailureSnackBar('Error: $e', context);
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  await googleSignIn.signOut();
}

messageSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              Icons.task_alt_outlined,
              size: 28,
              color: Colors.orange,
            )
          ],
        ),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.transparent,
    ),
  );
}

showSuccessSnackBar(
  String message,
  BuildContext context,
) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.done,
              color: Color.fromARGB(255, 66, 239, 83),
            )
          ],
        ),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.transparent,
    ),
  );
}

showFailureSnackBar(
  String message,
  BuildContext context,
) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              message,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const Icon(
              Icons.cancel,
              size: 28,
              color: Colors.red,
            )
          ],
        ),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.transparent,
    ),
  );
}

void addToCart(Product product, BuildContext context) {
  String email = FirebaseAuth.instance.currentUser!.email!;
  try {
    FirebaseFirestore.instance
        .collection('cart')
        .where('productId', isEqualTo: product.id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        FirebaseFirestore.instance.collection('cart').add({
          'productId': product.id,
          'productName': product.productName,
          'price': product.price,
          'quantity': 1,
          'email': email,
        }).then((value) {
          showSuccessSnackBar("Added to Cart", context);
        }).catchError((error) {
          showSuccessSnackBar('Failed: $error', context);
        });
      } else {
        messageSnackBar(context, 'Item already in the cart');
      }
    });
  } catch (e) {
    showFailureSnackBar(e.toString(), context);
  }
}


