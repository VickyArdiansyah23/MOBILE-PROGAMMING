import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/check_from.dart'; // Ensure this import path is correct
import '../models/shoe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailScreen extends StatelessWidget {
  final Shoe product;

  ProductDetailScreen({required this.product});

  final GlobalKey<_CheckoutFormState> _checkoutFormKey = GlobalKey<_CheckoutFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  product.imagePath,
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 20),
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Price: Rp ${_formatRupiah(product.price.toString())}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _showCheckoutDialog(context);
                  },
                  child: Text('Check Out'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCheckoutDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Checkout"),
          content: CheckoutForm(
            key: _checkoutFormKey,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_checkoutFormKey.currentState!.save()) {
                  Navigator.of(context).pop();

                  final formData = _checkoutFormKey.currentState!.getFormData();
                  final response = await _submitCheckoutData(formData);

                  if (response['status'] == 'success') {
                    _showQRCodeDialog(parentContext);
                  } else {
                    // Handle error
                  }
                }
              },
              child: Text("Proceed to Checkout"),
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, dynamic>> _submitCheckoutData(Map<String, String> formData) async {
    final url = 'http://192.168.1.5/flutter-app/checkout.php';
    final response = await http.post(Uri.parse(url), body: formData);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'status': 'error', 'message': 'Failed to save data'};
    }
  }

  void _showQRCodeDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("QR code"),
          content: Image.asset(
            'lib/images/logo2.png',
            width: 200,
            height: 200,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  String _formatRupiah(String price) {
    return price.replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}

class CheckoutForm extends StatefulWidget {
  CheckoutForm({Key? key}) : super(key: key);

  @override
  _CheckoutFormState createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _address = '';
  String _phone = '';
  String _productPrice = '';

  // Method to save form data
  bool save() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      print('Form data: {name: $_name, address: $_address, phone: $_phone, productPrice: $_productPrice}');
    }
    return isValid;
  }

  Map<String, String> getFormData() {
    return {
      'name': _name,
      'address': _address,
      'phone': _phone,
      'productPrice': _productPrice, // Add to formData
    };
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Full Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
            onSaved: (value) {
              _name = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Address'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
            onSaved: (value) {
              _address = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Phone Number'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
            onSaved: (value) {
              _phone = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Product Price'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the product price';
              }
              return null;
            },
            onSaved: (value) {
              _productPrice = value!;
            },
          ),
        ],
      ),
    );
  }
}
