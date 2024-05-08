import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_peace_project/view/cart_page/cart_widgets/cart_product_widget.dart';
import 'package:time_peace_project/view/checkout_page/checkout_page.dart';
import 'package:time_peace_project/widgets/constants.dart';
import '../../controller/cart_controller.dart';
import '../../model/cart_model.dart';
import '../../model/productmodel.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<Cart> data;

    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GetBuilder<CartController>(
          init: CartController(),
          builder: (controller) => Scaffold(
            backgroundColor: const Color.fromARGB(255, 232, 230, 230),
            appBar: AppBar(
              centerTitle: true,
              title: const Text("CART"),
            ),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('cart')
                        .where('email',
                            isEqualTo: FirebaseAuth.instance.currentUser!.email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print('Error: ${snapshot.error}');
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const SizedBox.shrink();
                      }

                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;

                      if (documents.isEmpty) {
                        return const Center(
                          child: Text(
                            'Your cart is empty!',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        );
                      }

                      List<Cart> cartData = documents
                          .map((doc) => Cart.fromSnapshot(doc))
                          .toList();
                      data = cartData;
                      return ListView.separated(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('products')
                                .doc(documents[index].get('productId'))
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.transparent,
                                  ),
                                );
                              }
                              if (snapshot.hasError) {
                                print('Error: ${snapshot.error}');
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                print("empty");
                                return const SizedBox.shrink();
                              }

                              var data = snapshot.data!.data();

                              Product product = Product.fromMap(
                                  data as Map<String, dynamic>,
                                  snapshot.data!.id);

                              return CustomCartProductWidget(
                                product: product,
                                cart: cartData[index],
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) => kSize5,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: size.height / 7.6,
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, .99),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
                width: size.width / 1.11,
                height: size.height / 9.5,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(46))),
                child: TextButton(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Proceed to checkout",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                      Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.green,
                        size: 40,
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CheckoutPage(cartData: data)));
                  },
                )),
          ),
        )
      ],
    );
  }
}
