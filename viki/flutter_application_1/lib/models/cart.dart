import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shoe.dart';

class Cart extends ChangeNotifier {
  // list of shoes for sale
  List<Shoe> shoeShop = [
    Shoe(
      name: 'Nike V2K Run',
      price: ' 1,909,000',
      description: 'Shoes',
      imagePath: 'lib/images/Nike V2K Run.png',
    ),
    Shoe(
      name: 'Air Jordan 1 Low SE',
      price: ' 1,909,000',
      description: 'Mens Shoes',
      imagePath: 'lib/images/Air Jordan 1 Low SE.png',
    ),
    Shoe(
      name: 'Nike Vomero 17',
      price: ' 2,489,000',
      description: 'Mens Road Running Shoes',
      imagePath: 'lib/images/Nike Vomero 17.png',
    ),
    Shoe(
      name: 'Nike SB Force 58',
      price: ' 1,149,000',
      description: 'Skate Shoes',
      imagePath: 'lib/images/Nike SB Force 58.png',
    ),
    Shoe(
      name: 'Jordan ADG 4',
      price: ' 2,018,000',
      description: 'Skate Shoes',
      imagePath: 'lib/images/NIKEGOLF.png',
    ),
  ];

  List<Shoe> userCart = [];

  List<Shoe> getShoeList() {
    return shoeShop;
  }

  List<Shoe> getUserCart() {
    return userCart;
  }

  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }

  int getQuantity(Shoe shoe) {
    int quantity = 0;
    for (Shoe cartShoe in userCart) {
      if (cartShoe == shoe) {
        quantity++;
      }
    }
    return quantity;
  }
}
