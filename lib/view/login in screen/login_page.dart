import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_peace_project/widgets/constants.dart';
import 'package:time_peace_project/widgets/custom_button.dart';
import 'package:time_peace_project/widgets/global_widgets.dart';
import '../../controller/login_controller.dart';

import '../../widgets/email_textformfield.dart';
import '../../widgets/password_textfromfeld.dart';
import 'widgets/widgets.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(loginBackgroundPicture),
                fit: BoxFit.fitHeight)),
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: const Alignment(0, 0),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                  width: size.width,
                  height: size.height / 1.4,
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        const CustomHeading(text: "L o g i N"),
                        kSize25,
                        CustomEmailTextField(
                          controller: controller.emailController,
                      
                          prefixIcon: Icons.email,
                        ),
                        kSize25,
                        PasswordField(
                          controller: controller.passwordController,
                          hintText: 'Password',
                          prefixIcon: Icons.lock,
                        ),
                        kSize10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: controller.navigateToForgotPassword,
                                child: const Text(
                                  "Forgot Password..?",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900),
                                ),
                              )
                            ],
                          ),
                        ),
                        kSize15,
                        CustomButton(
                          text: "Login",
                          onTap: controller.signIn,
                        ),
                        kSize10,
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 90),
                              child: Text(
                                "Don't have an account..?",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 55, vertical: 10),
                                child: InkWell(
                                  onTap: controller.navigateToSignUp,
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 2,
                                ),
                              ),
                              Text(
                                " OR ",
                                style: TextStyle(color: Colors.white),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 2,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GoogleSignInButton(
                onPressed: controller.signInWithGoogle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
