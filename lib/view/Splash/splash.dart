import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_peace_project/view/dash%20screen/dash.dart';

import '../login in screen/login_page.dart';

class SplashScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (user != null) {
        Get.off(() => const Dash());
      } else {
        Get.off(() =>  LoginScreen());
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/cartpng.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
