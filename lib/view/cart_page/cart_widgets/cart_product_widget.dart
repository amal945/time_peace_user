import 'package:flutter/material.dart';
import 'package:time_peace_project/view/cart_page/cart_widgets/cart_quantity_widget.dart';
import 'package:time_peace_project/view/cart_page/cart_widgets/cart_remove_button.dart';
import 'package:time_peace_project/view/checkout_page/global_checkout.dart';

import '../../../model/cart_model.dart';
import '../../../model/productmodel.dart';
import '../../../widgets/constants.dart';

class CustomCartProductWidget extends StatelessWidget {
  final Product product;
  final Cart cart;

  const CustomCartProductWidget(
      {Key? key, required this.product, required this.cart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: size.height / 5.5,
                  width: size.width / 3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(product.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 3),
                      child: Text(
                        product.productName,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        product.brand,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    kSize5,
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        product.price.toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    kSize15,
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0, bottom: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CartRemoveButton(
                            product: product,
                          ),
                          kWidth8,
                          CartQuantityWidget(
                            productId: product.id,
                            totalQuantiy: product.quantity,
                            currentQuantity: cart.quantity,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Material(
              color: Colors.yellowAccent,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GlobalCheckoutPage(product: product)));
                },
                splashColor: Colors.yellow,
                child: Container(
                  width: double.infinity,
                  height: size.height / 19,
                  decoration: const BoxDecoration(),
                  child: const Center(
                    child: Text(
                      "Buy now",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
