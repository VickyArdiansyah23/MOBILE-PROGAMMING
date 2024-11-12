import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/shop_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CheckoutList(),
    );
  }
}

class CheckoutList extends StatefulWidget {
  @override
  _CheckoutListState createState() => _CheckoutListState();
}

class _CheckoutListState extends State<CheckoutList> {
  List<dynamic> _checkouts = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _fetchCheckouts();
  }

  Future<void> _fetchCheckouts() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.5/flutter-app/checkoutlist.php'));

      if (response.statusCode == 200) {
        setState(() {
          _checkouts = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load checkouts: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching checkouts: $error');
    }
  }

  Future<void> _handleRefresh() async {
    await _fetchCheckouts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ShopPage()),
            );
          },
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: ListView.builder(
          itemCount: _checkouts.length,
          itemBuilder: (context, index) {
            final checkout = _checkouts[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                contentPadding: EdgeInsets.all(8.0), // Adjust the padding as needed
                title: Text(
                  checkout['nama_barang'] ?? 'No Name', // Display product name
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(checkout['address'] ?? 'No Address'),
                    SizedBox(height: 4.0),
                    Text('Phone: ${checkout['phone'] ?? 'No Phone'}'), // Display phone
                  ],
                ),
                trailing: Text(
                  'Price: ${checkout['productPrice'] ?? 'No Price'}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: checkout['image'] != null 
                  ? CircleAvatar(
                      backgroundImage: MemoryImage(base64Decode(checkout['image'])),
                      radius: 30, // Adjusted radius for a better image size
                    )
                  : CircleAvatar(
                      child: Icon(Icons.image, color: Colors.white), // Placeholder icon
                      backgroundColor: Colors.grey[400],
                      radius: 30, // Adjusted radius for a better image size
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}
