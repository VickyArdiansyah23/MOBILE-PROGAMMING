import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kamu adalah seperti sepatu yang melewati berbagai medan, hidup juga memerlukan kita untuk melangkah maju meski tak selalu nyaman. Tapi di setiap langkah, kita bisa menemukan kekuatan dan ketahanan yang belum pernah kita sadari sebelumnya. Sepatu bukan hanya alas kaki, tapi juga cermin dari perjalanan hidup kita. Saat kita mengenakan sepatu yang lama, kita bisa teringat pada jejak langkah yang telah kita tempuh. Namun, saat kita mengenakan sepatu yang baru, kita diberi kesempatan untuk menulis kisah baru, mengeksplorasi tempat-tempat baru, dan mengukir kenangan-kenangan yang tak terlupakan. Jadi, setiap langkah adalah kesempatan untuk menemukan diri kita sendiri, mengejar impian kita, dan menjadi versi terbaik dari diri kita yang sesungguhnya.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
