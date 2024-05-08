import 'package:flutter/material.dart';
import 'package:time_peace_project/view/home_screen/home.dart';
import 'package:time_peace_project/view/notification_screen/notification_screen.dart';
import 'package:time_peace_project/view/account_page/account_screen.dart';
import 'package:time_peace_project/view/gift_store_screen/gift_store.dart';

class TabNavigator extends StatelessWidget {
  final int index;

  const TabNavigator({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return  HomeScreen();
      case 1:
        return const GiftStore();
      case 2:
        return const NotficationScreen();
      case 3:
        return const ScreenAccount();
      default:
        return  HomeScreen();
    }
  }
}
