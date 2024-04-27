import 'package:flutter/material.dart';

class NotficationScreen extends StatefulWidget {
  const NotficationScreen({super.key});

  @override
  State<NotficationScreen> createState() => _NotficationScreenState();
}

class _NotficationScreenState extends State<NotficationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Notfications Screen")),
    );
  }
}
