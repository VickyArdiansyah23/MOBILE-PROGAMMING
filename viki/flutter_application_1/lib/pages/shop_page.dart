import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/shoe_tile.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/models/shoe.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<Cart>(
          builder: (context, cart, child) {
            return ListView.builder(
              itemCount: cart.getShoeList().length,
              itemBuilder: (context, index) {
                Shoe shoe = cart.getShoeList()[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ShoeTile(
                    shoe: shoe,
                    onTap: () => _addShoeToCart(context, shoe),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _addShoeToCart(BuildContext context, Shoe shoe) async {
    Provider.of<Cart>(context, listen: false).addItemToCart(shoe);

    // Data to send to PHP
    var data = {
      'shoe_name': shoe.name,
      'shoe_price': shoe.price,
      'shoe_description': shoe.description,
      'shoe_image_url': shoe.imagePath
    };

    var url = 'http://192.168.1.5/flutter-app/add_to_cart.php'; // Ganti dengan URL endpoint PHP
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 'success') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Successfully added'),
            content: Text('Check your cart'),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Failed to add'),
            content: Text(jsonResponse['message']),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to connect to server'),
        ),
      );
    }
  }
}
