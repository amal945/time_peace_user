import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenAccount extends StatefulWidget {
  const ScreenAccount({super.key});

  @override
  State<ScreenAccount> createState() => _ScreenAccountState();
}

class _ScreenAccountState extends State<ScreenAccount> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text("Profile Page "),
    ));
  }
}
