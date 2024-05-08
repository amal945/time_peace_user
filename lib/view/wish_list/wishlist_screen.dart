import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_peace_project/widgets/constants.dart';
import '../../controller/home_controller.dart';
import '../../model/functions.dart';
import '../../model/productmodel.dart';
import '../product_screen/product_detail_screen.dart';

class ScreenWishlist extends StatefulWidget {
  const ScreenWishlist({Key? key}) : super(key: key);

  @override
  State<ScreenWishlist> createState() => _ScreenWishlistState();
}

class _ScreenWishlistState extends State<ScreenWishlist> {
  @override
  void initState() {
    super.initState();
    getWishlistProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Wish List"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('wishlist')
              .where('email', isEqualTo: email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return documents.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => kSize20,
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
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              log('Error: ${snapshot.error}');
                              return Text('Error: ${snapshot.error}');
                            }

                            if (!snapshot.hasData || snapshot.data == null) {
                              return const SizedBox.shrink();
                            }

                            var data = snapshot.data!.data();
                            Product product = Product.fromMap(
                              data as Map<String, dynamic>,
                              snapshot.data!.id,
                            );

                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsPage(
                                      data: product,
                                      isLiked: isProductInWishlist(product.id),
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: size.width / 1,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: size.height / 4.6,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(product.image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              product.productName,
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              product.brand,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "RS:${product.price.toString()}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  removeFromWishlist(
                                                          product.id, context)
                                                      .then((value) {
                                                    setState(() {});
                                                  }).then((value) {
                                                    Get.find<HomeController>()
                                                        .update();
                                                  }).then((value) {
                                                    showSuccessSnackBar(
                                                        "Removed from WishList",
                                                        context);
                                                  });
                                                },
                                                child: const Text("Remove"))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(vertical: 250.0),
                      child: Center(
                        child: Text('Wishlist is Empty'),
                      ),
                    );
            } else if (snapshot.hasError) {
              Text('Error: ${snapshot.error}');
              log(snapshot.error.toString());
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
