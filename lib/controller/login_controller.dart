import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view/dash_screen/dash.dart';
import '../view/forgot_password_screen/forgot_password_screen.dart';
import '../view/signup_page/signup_page.dart';

class LoginController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  final _enteredEmail = TextEditingController();
  final _enteredPassword = TextEditingController();
  final RxBool _obscureText = true.obs;

  bool get obscureText => _obscureText.value;
  set obscureText(bool value) => _obscureText.value = value;

  get formKey => _formKey;

  @override
  void onClose() {
    _enteredEmail.dispose();
    _enteredPassword.dispose();
    super.onClose();
  }

  TextEditingController get emailController => _enteredEmail;
  TextEditingController get passwordController => _enteredPassword;

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _enteredEmail.text.trim(),
                password: _enteredPassword.text.trim())
            .then((value) => Get.offAll(
                  () => const Dash(),
                ));
      } catch (e) {
        Get.snackbar("Error", e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }



  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        await FirebaseAuth.instance.signInWithCredential(credential);
        Get.offAll(() => const Dash());
      }
    } catch (e) {
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          e.toString(),
        ),
      );
    }
  }

  void navigateToSignUp() {
    Get.to(() => SignUpPage());
  }

  void navigateToForgotPassword() {
    Get.to(() => const ForgotPassword());
  }
}
