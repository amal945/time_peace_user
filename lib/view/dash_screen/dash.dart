import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:time_peace_project/view/cart_page/cart.dart';
import '../account_page/account_screen.dart';
import '../gift_store_screen/gift_store.dart';
import '../home_screen/home.dart';
import '../notification_screen/notification_screen.dart';
import '../wish_list/wishlist_screen.dart';
import 'drawer_widget.dart';
import 'tab_navigation.dart';

class Dash extends StatefulWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  int currentTab = 0;
  late Widget currentScreen;

  @override
  void initState() {
    super.initState();
    currentScreen = HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ScreenWishlist(),
                ),
              );
            },
            icon: const Icon(Icons.favorite_border),
          ),
          const SizedBox(width: 15),
          InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScreenCart(),
                  ),
                );
              },
              child: const Icon(Icons.shopping_cart)),
          const SizedBox(width: 20),
        ],
      ),
      drawer: const DrawerWidget(),
      body: IndexedStack(
        index: currentTab,
        children: [
          HomeScreen(),
          const GiftStore(),
          const NotficationScreen(),
          const ScreenAccount(),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 223, 222, 222),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 223, 222, 222),
            color: Colors.black,
            activeColor: Colors.black,
            padding: const EdgeInsets.all(5),
            tabBackgroundColor: const Color.fromARGB(255, 165, 164, 164),
            gap: 8,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.card_giftcard,
                text: 'Gift Store',
              ),
              GButton(
                icon: Icons.notifications,
                text: 'Notifications',
              ),
              GButton(
                icon: Icons.person_2,
                text: 'Account',
              ),
            ],
            selectedIndex: currentTab,
            onTabChange: (index) {
              setState(() {
                currentTab = index;
                currentScreen = TabNavigator(index: index);
              });
            },
          ),
        ),
      ),
    );
  }
}
