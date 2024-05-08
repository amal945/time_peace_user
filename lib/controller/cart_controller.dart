import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/functions.dart';

class CartController extends GetxController {
  void removeFromCart(String productId, BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;
    try {
      FirebaseFirestore.instance
          .collection('cart')
          .where('productId', isEqualTo: productId)
          .where('email', isEqualTo: email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.first.reference.delete().then((value) {
            showSuccessSnackBar("Removed from cart", context);
          }).catchError((error) {
            showFailureSnackBar('Failed to remove:$error', context);
          });
        } else {
          messageSnackBar(context, 'Product not found');
        }
      });
    } catch (e) {
      showFailureSnackBar('Error $e', context);
    }
  }
}
