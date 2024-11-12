import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/register_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  bool _isUsernameEmpty = false;
  bool _isPasswordEmpty = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void loginUser() async {
    setState(() {
      _isUsernameEmpty = usernameController.text.isEmpty;
      _isPasswordEmpty = passwordController.text.isEmpty;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    // URL to the PHP login script
    String url = 'http://192.168.1.5/flutter-app/conn.php'; // Adjust with your URL

    try {
      // HTTP POST request to the server
      var response = await http.post(Uri.parse(url), body: {
        'username': usernameController.text,
        'password': passwordController.text,
      });

      // Debugging: Print response status and body
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Server response
      var data = jsonDecode(response.body);

      // Debugging: Print parsed data
      print('Parsed data: $data');

      // Check if the data contains user information
      if (data['status'] == 'success') {
        // Login successful, navigate to the next screen
        Navigator.pushReplacementNamed(context, '/intro_page');
      } else {
        // Login failed, show error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text(data['message']),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Debugging: Print error
      print('Error: $e');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('An error occurred: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()), // Navigate to RegisterPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue, // Adjust with your theme color
        automaticallyImplyLeading: false,// Ensure no leading icon is displayed
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        errorText: _isUsernameEmpty ? 'Username harus diisi' : null,
                      ),
                      autofillHints: [AutofillHints.username],
                      key: Key('username'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        errorText: _isPasswordEmpty ? 'Password harus diisi' : null,
                      ),
                      autofillHints: [AutofillHints.password],
                      key: Key('password'),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        loginUser();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: loginUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // button color
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextButton(
                      onPressed: navigateToRegister,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Belum punya akun? Daftar di sini',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 5), // Space between text and icon
                          Icon(Icons.arrow_forward, color: Colors.blue), // Arrow icon
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
