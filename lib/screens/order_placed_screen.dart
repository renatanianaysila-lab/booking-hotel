import 'package:flutter/material.dart';
import 'home_screen.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background seluruh layar = peach muda, persis foto
      backgroundColor: const Color(0xFFFFF0EB),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Teks utama ─────────────────────────────────
                const Text(
                  'Terima Kasih!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'InclusiveSans',
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Kamar hotel Anda\ntelah berhasil dipesan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'InclusiveSans',
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Selamat menikmati\nperjalanan Anda!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'InclusiveSans',
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 48),

                // ── Tombol Kembali ke Beranda ─────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF1510C),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Kembali ke Beranda',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'InclusiveSans',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}