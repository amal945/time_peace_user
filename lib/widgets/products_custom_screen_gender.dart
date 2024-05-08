// ignore_for_file: prefer_final_fields, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_peace_project/widgets/constants.dart';
import '../model/functions.dart';
import '../model/productmodel.dart';
import '../view/home_screen/widgets/custom_product_widget.dart';
import '../view/product_screen/product_detail_screen.dart';
import '../view/home_screen/widgets/textfield_products_screen.dart';

class ScreenGenderProducts extends StatefulWidget {
  const ScreenGenderProducts({Key? key, required this.gender})
      : super(key: key);
  final String gender;

  @override
  State<ScreenGenderProducts> createState() => _ScreenGenderProductsState();
}

class _ScreenGenderProductsState extends State<ScreenGenderProducts> {
  late List<Product> _products = [];
  late TextEditingController _searchController;
  bool _isFilter = false;

  bool isFilterApplied = false;

  int upperValue = 0;
  int lowerValue = 0;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.gender),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ProductCustomTextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  !_isFilter
                      ? InkWell(
                          onTap: () {
                            showFilterBottomSheet(context);
                            setState(() {
                              _isFilter = !_isFilter;
                            });
                          },
                          child: const Icon(Icons.filter_alt),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              _isFilter = !_isFilter;
                              isFilterApplied = false;
                            });
                          },
                          child: const Icon(Icons.close),
                        )
                ],
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .where('category', isEqualTo: widget.gender)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }
                  _products =
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    return Product.fromMap(
                      document.data() as Map<String, dynamic>,
                      document.id,
                    );
                  }).toList();

                  List<Product> filteredProducts;

                  if (isFilterApplied) {
                    filteredProducts = _products
                        .where((product) =>
                            product.price >= lowerValue &&
                            product.price <= upperValue &&
                            product.productName.toLowerCase().contains(
                                  _searchController.text.toLowerCase(),
                                ))
                        .toList();
                  } else {
                    filteredProducts = _products
                        .where((product) => product.productName
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase()))
                        .toList();
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      Product product = filteredProducts[index];

                      return CustomProductWidget(
                        isLiked: isProductInWishlist(product.id),
                        product: product,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              data: product,
                              isLiked: isProductInWishlist(product.id),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showFilterBottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        // _isBelow5000 = !_isBelow5000;
                        lowerValue = 0;
                        upperValue = 5000;
                        isFilterApplied = true;
                      });
                    },
                    child: Container(
                        width: size.width / 2.5,
                        height: size.height / 14,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Rs 0 - 5000',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        // _isBetween5kand10k = !_isBetween5kand10k;
                        lowerValue = 5000;
                        upperValue = 10000;
                        isFilterApplied = true;
                      });
                    },
                    child: Container(
                        width: size.width / 2.5,
                        height: size.height / 14,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Rs 5000 - 10000',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              kSize20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        // _isBetween10kand25k = !_isBetween10kand25k;
                        lowerValue = 10000;
                        upperValue = 25000;
                        isFilterApplied = true;
                      });
                    },
                    child: Container(
                        width: size.width / 2.5,
                        height: size.height / 14,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Rs 10000 - 25000',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        // is_Between25kand50k = !is_Between25kand50k;
                        lowerValue = 25000;
                        upperValue = 50000;
                        isFilterApplied = true;
                      });
                    },
                    child: Container(
                        width: size.width / 2.4,
                        height: size.height / 14,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Rs 25000 - 50000 ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
