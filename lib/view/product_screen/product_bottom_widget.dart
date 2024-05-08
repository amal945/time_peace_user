import 'package:flutter/material.dart';
import 'package:time_peace_project/model/functions.dart';
import 'package:time_peace_project/model/productmodel.dart';
import 'package:time_peace_project/view/checkout_page/global_checkout.dart';

class BottomProductWidget extends StatelessWidget {
  final Product data;
  const BottomProductWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height / 11,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            color: Colors.black,
            child: InkWell(
              onTap: () {
                addToCart(data, context);
              },
              splashColor: const Color.fromARGB(255, 77, 75, 75),
              child: SizedBox(
                width: size.width / 2,
                height: size.height / 9,
                child: const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_checkout_sharp,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Add to cart",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.yellow,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GlobalCheckoutPage(product: data)));
              },
              splashColor: Color.fromARGB(255, 248, 207, 43),
              child: SizedBox(
                width: size.width / 2,
                height: size.height / 9,
                child: const Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Row(
                    children: [
                      Text(
                        "Buy Now",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 41, 41, 41),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.flash_on,
                        color: Colors.deepOrangeAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
