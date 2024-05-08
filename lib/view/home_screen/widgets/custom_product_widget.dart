import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:time_peace_project/controller/home_controller.dart';
import 'package:time_peace_project/model/productmodel.dart';
import '../../../widgets/lottie_product_tile.dart';

class CustomProductWidget extends StatefulWidget {
  final Product product;
  final VoidCallback onTap;
  final bool isLiked;
  const CustomProductWidget({
    Key? key,
    required this.product,
    required this.isLiked,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomProductWidget> createState() => _CustomProductWidgetState();
}

class _CustomProductWidgetState extends State<CustomProductWidget> {
  late bool isLiked;
  late HomeController controller;

  @override
  void initState() {
    controller = Get.find();
    isLiked = widget.isLiked;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          width: size.width / 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.black,
          ),
          child: Column(
            children: [
              Container(
                height: size.height / 4.7,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder:
                        'assets/animations/Animation - grid_loading.json',
                    image: widget.product.image,
                    placeholderErrorBuilder: (context, error, stackTrace) {
                      return LottiePlaceholderProductTile();
                    },
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.fill,
                    height: size.height / 4.8,
                    width: size.width / 2.2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      widget.product.productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rs:${widget.product.price.toString()}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    GetBuilder<HomeController>(
                      builder: (controller) {
                        return LikeButton(
                          isLiked: isLiked,
                          size: 30,
                          circleColor: const CircleColor(
                            start: Colors.blue,
                            end: Colors.red,
                          ),
                          likeBuilder: (isLiked) {
                            return Icon(
                              isLiked ? Icons.favorite : Icons.favorite,
                              color: isLiked ? Colors.red : Colors.grey,
                              size: 30,
                            );
                          },
                          onTap: (isLiked) async {
                            setState(() {
                              this.isLiked = !this.isLiked;
                            });

                            await controller.addToWishlistController(
                                widget.product.id, context);
                            return this.isLiked;
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
