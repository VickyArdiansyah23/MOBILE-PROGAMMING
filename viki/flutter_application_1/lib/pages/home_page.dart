import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_nav_bar.dart';
import 'package:flutter_application_1/pages/about_page.dart';
import 'package:flutter_application_1/pages/cart_page.dart';
import 'package:flutter_application_1/pages/checkoutlist.dart';
import 'package:flutter_application_1/pages/shop_page.dart';
import 'package:flutter_application_1/pages/login_page.dart'; // Import LoginPage here

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This selected index is to control the bottom nav bar
  int _selectedIndex = 0;

  // This method will update our selected index when the user taps on the bottom bar
  void navigateBottom(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Pages to display
  final List<Widget> _pages = [
    // Shop page
    const ShopPage(),

    // Cart page
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottom(index),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 9.0),
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // Logo
                DrawerHeader(
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/images/logo.png',
                        color: Colors.white,
                        height: 100,
                        width: 100,
                      ),
                      Text(
                        'SNEAKERS JAKARTA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(
                    color: Colors.grey[800],
                  ),
                ),
                // Other pages
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(Icons.home, color: Colors.white),
                    title: Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ListTile(
                    leading: Icon(Icons.info, color: Colors.white),
                    title: Text(
                      'About',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Navigate to AboutPage when the "About" item is tapped
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => AboutPage()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ListTile(
                    leading: Icon(Icons.shopping_bag, color: Colors.white),
                    title: Text(
                      'Shop',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Navigate to ShopPage when the "Shop" item is tapped
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CheckoutList()),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10),
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navigate to LoginPage when Logout is tapped
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
