import 'package:flutter/material.dart';

class NotficationScreen extends StatefulWidget {
  const NotficationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NotficationScreen> createState() => _NotficationScreenState();
}

class _NotficationScreenState extends State<NotficationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
      child: Text("Notification Screen"),
    ));
  }
}
