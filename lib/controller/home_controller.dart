import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_peace_project/model/brand_model.dart';
import 'package:time_peace_project/model/functions.dart';
import 'package:time_peace_project/model/productmodel.dart';
import 'package:time_peace_project/widgets/products_custom_screen_gender.dart';
import 'package:time_peace_project/view/product_screen/product_detail_screen.dart';
import '../view/home_screen/widgets/brand_products_screen.dart';

class HomeController extends GetxController {
  late TextEditingController searchController;
  late List<Brand> brandList = [];
  late List<Product> productList = [];
  late List<String> _wishlistProducts = [];

  isProductInWishlist(String productId) {
    getWishlistProducts();
    return _wishlistProducts.contains(productId);
  }

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    getWishlistProducts().then((value) {});
    fetchBrands();
  }

  void fetchBrands() async {
    FirebaseFirestore.instance
        .collection("brands")
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      brandList.clear();
      brandList = snapshot.docs.map((DocumentSnapshot document) {
        return Brand.fromMap(
          document.data() as Map<String, dynamic>,
          document.id,
        );
      }).toList();
      update();
    });
  }

  addToWishlistController(String productId, BuildContext context) async {
    await addToWishlist(productId, context);
  }

  void searchProducts(String value) async {
    FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      productList.clear();
      productList = snapshot.docs.map((DocumentSnapshot document) {
        return Product.fromMap(
          document.data() as Map<String, dynamic>,
          document.id,
        );
      }).toList();
    });
  }

  void navigateToGenderProducts(String gender) {
    Get.to(() => ScreenGenderProducts(gender: gender));
  }

  void navigateToBrandProducts(String brandName) {
    Get.to(() => ScreenBrandProducts(brand: brandName));
  }

  void navigateToProductDetails(Product product) {
    Get.to(() => ProductDetailsPage(
          data: product,
          isLiked: isProductInWishlist(product.id),
        ));
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
