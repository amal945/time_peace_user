  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
import 'package:time_peace_project/model/productmodel.dart';

  import '../../../controller/cart_controller.dart';

  class CartRemoveButton extends StatelessWidget {
    final Product product;
    const CartRemoveButton({super.key, required this.product});

    @override
    Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return Container(
        width: size.width / 3.7,
        height: size.height / 18,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 80, 77, 77),
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: TextButton(
          onPressed: () {
            Get.find<CartController>().removeFromCart(product.id, context);
          },
          child: const Text(
            "Remove",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
