import 'package:flutter/material.dart';
import 'package:time_peace_project/model/productmodel.dart';
import 'package:time_peace_project/view/product_screen/product_bottom_widget.dart';
import 'package:time_peace_project/view/product_screen/product_image_widget.dart';
import 'package:time_peace_project/widgets/like_button_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product data;
  final bool isLiked;

  const ProductDetailsPage({
    Key? key,
    required this.data,
    required this.isLiked,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Product image
                ProductDetailImageWidget(imageUrl: widget.data.image),
                // Like Button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LikeButtonWidget(
                          productId: widget.data.id, isLiked: isLiked)
                    ],
                  ),
                ),
                // Product title
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Text(
                        widget.data.productName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                  ],
                ),

                // Product description
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Text(widget.data.description),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Text(
                    'Color:${widget.data.color.toUpperCase()}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                // Product color

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Price: ${widget.data.price.toString()}",
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
           BottomProductWidget(data: widget.data,)
        ],
      ),
    );
  }
}
