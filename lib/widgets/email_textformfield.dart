import 'package:flutter/material.dart';

class CustomEmailTextField extends StatelessWidget {
  final TextEditingController? controller;

  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? obscureText;
  final bool? isPassword;

  const CustomEmailTextField({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 25, right: 25), 
      child: TextFormField(
        controller: controller,
        obscureText: isPassword! ? obscureText! : false,
        validator: (value) {
          if (value!.isEmpty ||
              !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                  .hasMatch(value.trim())) {
            return 'Enter a valid Email';
          }
          return null;
        },
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon:
              prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
          suffixIcon:
              suffixIcon != null ? Icon(suffixIcon, color: Colors.grey) : null,
          hintText: "Email Address",
        ),
      ),
    );
  }
}
