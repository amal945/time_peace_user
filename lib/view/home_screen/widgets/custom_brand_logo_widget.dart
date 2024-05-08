import 'package:flutter/material.dart';
import 'package:time_peace_project/model/brand_model.dart';

import '../../../widgets/placeholder_lottie.dart';

class BrandLogoWidget extends StatelessWidget {
  final Brand data;
  final Size size;

  const BrandLogoWidget({
    Key? key,
    required this.data,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            width: size.width / 6,
            height: size.width / 6,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(34),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: FadeInImage.assetNetwork(
                placeholder:
                    'assets/animations/Animation - grid_loading.json', // Replace 'assets/loading.json' with your Lottie animation file path
                image: data.brandLogo,
                placeholderErrorBuilder: (context, error, stackTrace) {
                  return LottiePlaceholder(); // Use LottiePlaceholder as a fallback placeholder
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 25,
        ),
      ],
    );
  }
}
