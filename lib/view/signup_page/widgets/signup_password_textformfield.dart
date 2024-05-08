import 'package:flutter/material.dart';

class SignUpPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController confirmPassword;
  final String hintText;

  const SignUpPasswordField({
    Key? key,
    required this.confirmPassword,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  _SignUpPasswordFieldState createState() => _SignUpPasswordFieldState();
}

class _SignUpPasswordFieldState extends State<SignUpPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: (value) {
        if (value.toString().trim().length < 6) {
          return "Password must be at least 6  character long";
        }
        if (widget.confirmPassword.text.trim() != value.toString().trim()) {
          return "Passwords does not match";
        }

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
