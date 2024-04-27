// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../account page/account_screen.dart';
import '../gift_store_screen/gift_store.dart';
import '../home screen/home.dart';
import '../login in screen/login_page.dart';
import '../notification screen/notification_screen.dart';

class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  bool isLoggedOut = false;
  @override
  void dispose() {
    super.dispose();
  }

  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();

  Future<void> alert() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Are you sure you want to logout?",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () async {
                await signOut();
                if (isLoggedOut) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                }
              },
              child: const Text(
                "Continue",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    Navigator.of(context).pop();
    final user = FirebaseAuth.instance.currentUser;
    print(user.toString());
    setState(() {
      isLoggedOut = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: const [
          Icon(Icons.favorite_border),
          SizedBox(
            width: 15,
          ),
          Icon(Icons.shopping_cart),
          SizedBox(
            width: 20,
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[200],
          child: ListView(
            children: [
              const DrawerHeader(
                  child: Center(
                      child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/cartpng.png"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Amal S',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat"),
                      ),
                    ],
                  )
                ],
              ))),
              const ListTile(
                leading: Icon(Icons.policy),
                title: Text(
                  "Privacy Policy",
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.article),
                title: Text(
                  "About Us",
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.question_answer),
                title: Text(
                  "Terms and Conditions",
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  alert();
                  // await signOut();
                  // if (isLoggedOut) {
                  //   Navigator.pushAndRemoveUntil(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const LoginScreen()),
                  //       (route) => false);
                  // }
                },
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
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
                switch (index) {
                  case 0:
                    currentScreen = const HomeScreen();
                    break;
                  case 1:
                    currentScreen = const GiftStore();
                    break;
                  case 2:
                    currentScreen = const NotficationScreen();
                    break;
                  case 3:
                    currentScreen = const ScreenAccount();
                    break;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
