import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../view/account_page/account_screen.dart';
import '../view/gift_store_screen/gift_store.dart';
import '../view/home_screen/home.dart';
import '../view/login_in_screen/login_page.dart';
import '../view/notification_screen/notification_screen.dart';


class DashController extends GetxController {
  bool isLoggedOut = false;
  int currentTab = 0;
  late Widget currentScreen;

  @override
  void onInit() {
    super.onInit();
    currentScreen = HomeScreen();
  }

  void changeScreen(int index) {
    switch (index) {
      case 0:
        currentScreen = HomeScreen();
        break;
      case 1:
        currentScreen = const GiftStore();
        break;
      case 2:
        currentScreen = const NotficationScreen();
        break;
      case 3:
        currentScreen = const ScreenAccount();
        break;
      default:
        currentScreen = HomeScreen();
    }
    currentTab = index;
    update();
  }

  Future<void> alert(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Are you sure you want to logout?",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await signOut();
                if (isLoggedOut) {
                  Get.offAll(() => LoginScreen());
                }
              },
              child: const Text(
                "Continue",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    final user = FirebaseAuth.instance.currentUser;
    print(user.toString());
    isLoggedOut = true;
    update();
  }
}
