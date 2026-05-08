import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gambar lingkaran
          Positioned(
            left: 0,
            right: 0,
            top: 60,
            child: Center(
              child: Image.asset(
                'assets/Ellipse_1.png',
                width: 346,
                height: 346,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 346,
                    height: 346,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.hotel,
                      size: 100,
                      color: Color(0xFFF1510C),
                    ),
                  );
                },
              ),
            ),
          ),

          // Teks
          Positioned(
            left: 0,
            right: 0,
            top: 447,
            child: Center(
              child: SizedBox(
                width: 266,
                child: const Text(
                  'Temukan Tempat\nMenginap Terbaikmu',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.black,
                    fontFamily: 'InclusiveSans',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // Tombol Mulai Sekarang
          Positioned(
            left: 0,
            right: 0,
            bottom: 120,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF1510C),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(248, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                label: const Text(
                  'Mulai Sekarang',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    fontFamily: 'InclusiveSans',
                  ),
                ),
                icon: const Icon(Icons.arrow_forward, size: 24),
                iconAlignment: IconAlignment.end,
              ),
            ),
          ),
        ],
      ),
    );
  }
}