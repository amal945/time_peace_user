import 'package:flutter/material.dart';

import 'custom_workwear_banner.dart';

class WorkWearBanner extends StatelessWidget {
  const WorkWearBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return const BannerWithText(
                imageUrl: "assets/workwear_banner_1.webp",
                title: "WorkWear",
                description:
                    "Crafted with precision and built for durability, these timekeeping instruments offer a perfect blend of form and function.",
              );
  }
}
