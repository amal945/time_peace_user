// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_peace_project/Widgets/constants.dart';

import '../login in screen/login_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _enteredEmail = TextEditingController();
  final formKey = GlobalKey<FormState>();
  showErrorMessage(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $error"),
      ),
    );
  }

  showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text("Error: $message"),
      ),
    );
  }

  navigateToLoginPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future passwordReset() async {
    if (formKey.currentState!.validate()) {
      print("validation success");
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _enteredEmail.text.trim());

        showSuccessMessage("Password reset mail sent successfully");
        Future.delayed(const Duration(seconds: 2)).then(navigateToLoginPage());
      } on FirebaseAuthException catch (e) {
        showErrorMessage(e.toString());
        print(e);
      }
    }
  }

  @override
  void dispose() {
    _enteredEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Forgot Password",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: "Montserrat"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Dont worry sometimes people can forget too,enter your email and we will send you a password reset link....",
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  color: Color.fromARGB(255, 75, 74, 74)),
            ),
            kSize35,
            Form(
              key: formKey,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                    border: Border.all(color: Colors.grey, width: 2)),
                child: TextFormField(
                  controller: _enteredEmail,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                      showErrorMessage("Enter Valid Email");
                      return;
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: "E-Mail",
                      hintStyle: TextStyle(fontFamily: "Montserrat"),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.email)),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(
                          size.width - 50, 50), // specify width and height here
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black, // specify button color here
                    ),
                  ),
                  onPressed: () {
                    passwordReset();
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
