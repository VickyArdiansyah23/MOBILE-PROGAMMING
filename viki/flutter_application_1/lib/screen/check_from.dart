import 'package:flutter/material.dart';

class CheckoutForm extends StatefulWidget {
  const CheckoutForm({Key? key}) : super(key: key);

  @override
  CheckoutFormState createState() => CheckoutFormState();
}

class CheckoutFormState extends State<CheckoutForm> {
  final _formKey = GlobalKey<FormState>();

  // Method to save form data
  bool save() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
    return isValid;
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
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Address'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
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
          ),
        ],
      ),
    );
  }
}
