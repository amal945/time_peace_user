import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_peace_project/view/signup_page/widgets/signup_password_textformfield.dart';
import 'package:time_peace_project/widgets/constants.dart';
import 'package:time_peace_project/widgets/custom_button.dart';
import 'package:time_peace_project/widgets/global_widgets.dart';
import '../../controller/signup_controller.dart';
import '../../widgets/custom_textformfeld.dart';
import 'widgets/signup_email_textformfeild.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(loginBackgroundPicture),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomHeadingSignUp(text: "Sign Up"),
                    kSize20,
                    CustomTextField(
                      controller: controller.nameController,
                      hintText: 'Name',
                      prefixIcon: Icons.person_outline,
                      keyboardtype: TextInputType.name,
                      validator: (value) {
                        if (value!.trim().isEmpty || value.trim().length < 4) {
                          return "Username should be at least 4 characters";
                        }
                        if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value.trim())) {
                          return "Enter a valid name (characters only)";
                        }
                        return null;
                      },
                    ),
                    kSize20,
                    CustomTextField(
                      controller: controller.phoneNumberController,
                      hintText: "Phone number",
                      prefixIcon: Icons.phone,
                      keyboardtype: TextInputType.phone,
                      validator: (value) {
                        if (controller.phoneNumberController.text
                            .trim()
                            .isEmpty) {
                          return 'Phone number is required';
                        } else if (controller.phoneNumberController.text
                                .trim()
                                .length <
                            10) {
                          return "Phone number must atleat be 10 digits";
                        } else if (!RegExp(r'^(?!([0-9])\1{9}$)[0-9]{10}$')
                            .hasMatch(
                                controller.phoneNumberController.text.trim())) {
                          return "Please enter a valid phone number";
                        }
                        return null;
                      },
                    ),
                    kSize20,
                    SignUpCustomEmailTextField(
                      controller: controller.emailController,
                      obscureText: false,
                      prefixIcon: Icons.email,
                    ),
                    kSize20,
                    SignUpPasswordField(
                      confirmPassword: controller.confirmPasswordController,
                      controller: controller.passwordController,
                      hintText: 'Password',
                    ),
                    kSize20,
                    SignUpPasswordField(
                      confirmPassword: controller.passwordController,
                      controller: controller.confirmPasswordController,
                      hintText: "Confirm Password",
                    ),
                    kSize20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: InkWell(
                              onTap: () {
                                controller.signUp();
                              },
                              child: const CustomButton(text: "Sign Up")),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
