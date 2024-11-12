import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/cart_item.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/models/shoe.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        final List<Shoe> cartItems = cart.getUserCart();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Cart',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 20),
              Expanded(
                child: cartItems.isEmpty
                    ? Center(
                        child: Text(
                          'Your cart is empty!',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final Shoe shoe = cartItems[index];
                          // Pass actual quantity to CartItem
                          final int quantity = cart.getQuantity(shoe);
                          return CartItem(shoe: shoe, quantityText: '$quantity');
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
