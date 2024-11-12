import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController namaController = TextEditingController(); // Controller untuk nama

  bool _isNamaEmpty = false;
  bool _isUsernameEmpty = false;
  bool _isPasswordEmpty = false;

  void registerUser() async {
    setState(() {
      // Set flag untuk mengecek apakah input kosong
      _isNamaEmpty = namaController.text.isEmpty;
      _isUsernameEmpty = usernameController.text.isEmpty;
      _isPasswordEmpty = passwordController.text.isEmpty;
    });

    // Cek apakah ada field yang kosong
    if (_isNamaEmpty || _isUsernameEmpty || _isPasswordEmpty) {
      // Tampilkan dialog error jika ada field yang kosong
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registration Failed'),
          content: Text('Nama, username, dan password harus diisi.'),
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
      return;
    }

    // URL ke skrip PHP register.php
    String url = 'http://192.168.1.5/flutter-app/register.php'; // Sesuaikan dengan URL Anda

    try {
      // Permintaan HTTP POST ke server
      var response = await http.post(Uri.parse(url), body: {
        'username': usernameController.text,
        'password': passwordController.text,
        'nama': namaController.text, // Mengirim data nama ke server
      });

      // Debugging: Print response status and body
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Tanggapan dari server
      var data = jsonDecode(response.body);

      // Debugging: Print parsed data
      print('Parsed data: $data');

      // Periksa apakah registrasi berhasil
      if (data['success'] == true) {
        // Registrasi sukses, tampilkan pesan sukses
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Registration Successful'),
            content: Text('User registered successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/login_page'); // Navigasi kembali ke halaman login
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Registrasi gagal, tampilkan pesan kesalahan dari server
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Registration Failed'),
            content: Text('Error: ${data['message']}'),
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
          title: Text('Registration Failed'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue, // Sesuaikan dengan warna tema aplikasi Anda
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: namaController,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      errorText: _isNamaEmpty ? 'Nama harus diisi' : null,
                    ),
                    autofillHints: [AutofillHints.name],
                    key: Key('nama'),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 20.0),
                  TextField(
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
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: passwordController,
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
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // text color
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
