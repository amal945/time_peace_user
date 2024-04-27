// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_peace_project/view/product_screen/product_detail_screen.dart';

import '../../model/productmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                    width: size.width / 1.1,
                    height: size.height / 9,
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintStyle: const TextStyle(color: Colors.black)),
                    )),
              ),
            ]),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Shop for",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      color: Colors.grey,
                      width: size.width / 2,
                      height: size.height / 7,
                      child: Row(
                        children: [
                          Container(
                            width: size.width / 4,
                            height: size.height / 6,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/men_with_watch.webp"),
                                    fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Transform.rotate(
                              angle: 11,
                              child: Text(
                                'Men',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      color: Colors.grey,
                      width: size.width / 2,
                      height: size.height / 7,
                      child: Row(
                        children: [
                          Container(
                            width: size.width / 4,
                            height: size.height / 6,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/women_with_watch.jpg"),
                                    fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Transform.rotate(
                              angle: 11,
                              child: const Text(
                                'Women',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                   const SizedBox(
                      width: 8,
                    ),
                    Container(
                      color: Colors.grey,
                      width: size.width / 2,
                      height: size.height / 7,
                      child: Row(
                        children: [
                          Container(
                            width: size.width / 4,
                            height: size.height / 6,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/kids_with_watch.png"),
                                    fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Transform.rotate(
                              angle: 11,
                              child: const Text(
                                'Kids',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('products')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (snapshot.data == null ||
                            snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('No products found.'));
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics:const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Product product = Product.fromMap(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>,
                              snapshot.data!.docs[index].id,
                            );

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(
                                    data: product,
                                  ),
                                )),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 192, 189, 189),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: size.width / 2.8,
                                        height: size.height / 6,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                bottomLeft:
                                                    Radius.circular(12)),
                                            image: DecorationImage(
                                                image:
                                                    NetworkImage(product.image),
                                                fit: BoxFit.fill)),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: size.width / 2,
                                        height: size.height / 6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.productName,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Rs:${product.price.toString()}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 35,
                                                ),
                                                Icon(Icons.favorite_border),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
