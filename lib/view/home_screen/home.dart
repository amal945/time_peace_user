import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_peace_project/model/brand_model.dart';
import 'package:time_peace_project/model/functions.dart';
import 'package:time_peace_project/model/productmodel.dart';
import 'package:time_peace_project/view/home_screen/widgets/custom_brand_logo_widget.dart';
import 'package:time_peace_project/view/home_screen/widgets/custom_product_widget.dart';
import 'package:time_peace_project/view/home_screen/widgets/workwear_banner_widget.dart';
import 'package:time_peace_project/view/product_screen/product_detail_screen.dart';
import 'package:time_peace_project/widgets/constants.dart';
import 'package:time_peace_project/controller/home_controller.dart';
import '../workwear_page/workwear_page.dart';
import 'widgets/custom_category_widget.dart';
import 'widgets/textfield_custom.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: GetBuilder<HomeController>(
          builder: (controller) {
            return Column(
              children: [
                CustomTextField(
                  controller: controller.searchController,
                  onChanged: (value) {
                    controller.searchProducts(value);
                  },
                ),
                if (controller.searchController.text.isEmpty) ...[
                  kSize10,
                  const Padding(
                    padding: EdgeInsets.only(left: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Shop for",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  kSize10,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.navigateToGenderProducts("Mens");
                            },
                            child: const CustomCategoryWidget(
                              text: 'Men',
                              imageUrl: 'assets/men_with_watch.webp',
                            ),
                          ),
                          kWidth8,
                          InkWell(
                            onTap: () {
                              controller.navigateToGenderProducts("Womens");
                            },
                            child: const CustomCategoryWidget(
                              text: "Women",
                              imageUrl: "assets/women_with_watch.jpg",
                            ),
                          ),
                          kWidth8,
                          InkWell(
                            onTap: () {
                              controller.navigateToGenderProducts("Kids");
                            },
                            child: const CustomCategoryWidget(
                              text: "Kids",
                              imageUrl: "assets/kids_with_watch.png",
                            ),
                          ),
                          kWidth8,
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Pick a Brand",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  kSize10,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("brands")
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            }
                            if (snapshot.data == null ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text('No brand found.'),
                              );
                            }

                            List<Brand> brands = snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              return Brand.fromMap(
                                document.data() as Map<String, dynamic>,
                                document.id,
                              );
                            }).toList();

                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: brands
                                    .map(
                                      (data) => InkWell(
                                        onTap: () {
                                          controller.navigateToBrandProducts(
                                            data.brandName,
                                          );
                                        },
                                        child: BrandLogoWidget(
                                          data: data,
                                          size: size,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                  ),
                  kSize15,
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const WorkWearProductsScreen()));
                      },
                      child: const WorkWearBanner()),
                ],
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }
                          if (snapshot.data == null ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text('No products found.'),
                            );
                          }
                          List<Product> products = snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            return Product.fromMap(
                              document.data() as Map<String, dynamic>,
                              document.id,
                            );
                          }).toList();

                          // Filter products based on search query
                          List<Product> filteredProducts = products
                              .where(
                                (product) =>
                                    product.productName.toLowerCase().contains(
                                          controller.searchController.text
                                              .toLowerCase(),
                                        ),
                              )
                              .toList();

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

                              return GetBuilder<HomeController>(
                                builder: (controller) {
                                  return CustomProductWidget(
                                    isLiked: isProductInWishlist(product.id),
                                    product: product,
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsPage(
                                          data: product,
                                          isLiked:
                                              isProductInWishlist(product.id),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
