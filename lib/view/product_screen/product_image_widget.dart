import 'package:flutter/material.dart';

class ProductDetailImageWidget extends StatelessWidget {
  final String imageUrl;
  const ProductDetailImageWidget({super.key,required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: size.width / 1.2,
          height: size.height / 2.2,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(imageUrl))),
        ));
  }
}
