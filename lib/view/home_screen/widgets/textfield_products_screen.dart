import 'package:flutter/material.dart';

class ProductCustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const ProductCustomTextField({
    Key? key,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ProductCustomTextField> createState() => _ProductCustomTextFieldState();
}

class _ProductCustomTextFieldState extends State<ProductCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 13,
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: "Search",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintStyle: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
