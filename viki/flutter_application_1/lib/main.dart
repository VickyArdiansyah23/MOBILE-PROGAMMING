import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/pages/about_page.dart';
import 'package:flutter_application_1/pages/cart_page.dart';
import 'package:flutter_application_1/pages/checkoutlist.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/intro_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/shop_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          '/intro_page': (context) => IntroPage(),
          '/login_page': (context) => LoginPage(),
          '/home_page' : (context) => HomePage(),
          '/register_page' : (context) => ShopPage(),
          '/checkoulist': (context) => CheckoutList(),
          '/shop_page' : (context) => ShopPage(),
          '/cart_page' : (context) => CartPage(),
          '/about_page' : (context) => AboutPage(),
        },
      ),
    );
  }
}
