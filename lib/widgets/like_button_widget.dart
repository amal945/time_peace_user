import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_peace_project/controller/home_controller.dart';

class LikeButtonWidget extends StatefulWidget {
  final String productId;
  final bool isLiked;

  const LikeButtonWidget({
    Key? key,
    required this.productId,
    required this.isLiked,
  }) : super(key: key);

  @override
  LikeButtonWidgetState createState() => LikeButtonWidgetState();
}

class LikeButtonWidgetState extends State<LikeButtonWidget> {
  late HomeController _homeController;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    _homeController = Get.find<HomeController>();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        setState(() {
          isLiked = !isLiked;
        });
        await _homeController.addToWishlistController(
          widget.productId,
          context,
        );
        Get.find<HomeController>().update();
      },
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.grey,
        size: 30,
      ),
    );
  }
}
