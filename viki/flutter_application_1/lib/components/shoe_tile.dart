import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shoe.dart';

class ShoeTile extends StatelessWidget {
  final Shoe shoe;
  final VoidCallback onTap;

  ShoeTile({Key? key, required this.shoe, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // shoe pic
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(shoe.imagePath),
          ),

          // description
          Text(
            shoe.description,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 10),

          // price + details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // shoe name
                  Text(
                    shoe.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // price
                  Text(
                    '\Rp' + shoe.price,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              // plus button
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
