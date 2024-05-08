import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../view/dash_screen/dash.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final RxBool obscureText = true.obs;

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      try {
        // Create user with email and password
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        await addUserDetails(
            nameController.text.trim(),
            emailController.text.trim(),
            int.parse(phoneNumberController.text.trim()));

        // Check if user was successfully created
        if (userCredential.user != null) {
          emailController.text = "";
          passwordController.text = "";
          confirmPasswordController.text = "";
          // Navigate to another page (replace 'YourPage()' with your desired page)
          Get.offAll(const Dash());
        }
      } catch (e) {
        // Handle any errors that occur during sign-up
      
        // Display error message to the user
        Get.snackbar(
          "Error",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  Future<void> addUserDetails(String userName, String email, int number) async {
    await FirebaseFirestore.instance.collection("users").add({
      "username": userName,
      "phonenumber": number,
      "email": email,
    });
  }
}
