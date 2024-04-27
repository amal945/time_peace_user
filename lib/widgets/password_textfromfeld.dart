
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;

  const PasswordField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}




class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        validator: (value) {
          if (value!.trim().length < 6) {
            return "Password must be at least 6 characters";
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
            widget.prefixIcon,
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
              color: Colors.grey,
            ),
          ),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}