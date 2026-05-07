import 'package:flutter/material.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 60,
            child: Center(
              child: Image.asset(
                'assets/Ellipse_1.png',
                width: 346,
                height: 346,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 447,
            child: Center(
              child: SizedBox(
                width: 266,
                child: const Text(
                  'Temukan Tempat Menginap Terbaikmu',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 120,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  debugPrint('Mulai Sekarang ditekan');
                },
                child: Container(
                  width: 248,
                  height: 54,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1510C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mulai Sekarang',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Image(
                        image: AssetImage('assets/arrows_1.png'),
                        width: 28,
                        height: 28,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}