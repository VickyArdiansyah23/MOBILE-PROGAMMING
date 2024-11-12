import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/pages/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../models/shoe.dart';

class CartItem extends StatefulWidget {
  final Shoe shoe;

  CartItem({
    Key? key,
    required this.shoe, required String quantityText,
  }) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  void removeItemFromCart() {
    Provider.of<Cart>(context, listen: false).removeItemFromCart(widget.shoe);
  }

  void showProductDetail() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: widget.shoe), // navigate ke halaman detail produk dengan menyertakan objek produk
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListTile(
              leading: Image.asset(widget.shoe.imagePath),
              title: Text(widget.shoe.name),
              subtitle: Text(widget.shoe.price),
            ),
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: showProductDetail, // Panggil fungsi untuk menampilkan detail produk ketika ikon info diklik
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: removeItemFromCart,
          ),
        ],
      ),
    );
  }
}
