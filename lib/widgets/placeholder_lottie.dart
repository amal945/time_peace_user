import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: 100, // Adjust placeholder width as needed
      height: 100, // Adjust placeholder height as needed
      child: Lottie.asset(
          width: size.width / 9,
          height: size.height / 18,
          'assets/animations/Animation - grid_loading.json'), // Replace 'assets/loading.json' with your Lottie animation file path
    );
  }
}
