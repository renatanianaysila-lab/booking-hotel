import 'package:flutter/material.dart';
import 'order_placed_screen.dart';

class BookingSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> hotel;
  final String checkIn;
  final String checkOut;
  final int guests;
  final String notes;

  const BookingSummaryScreen({
    super.key,
    required this.hotel,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    this.notes = '',
  });

  String _formatRupiah(int amount) {
    final s = amount.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return 'Rp${buf.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    const int basePrice = 850000;
    const int tax = 150000;
    const int total = basePrice + tax;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  // Tombol back — arrow biasa, bukan dalam lingkaran
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back,
                        color: Colors.black, size: 24),
                  ),
                  const Expanded(
                    child: Text(
                      'Ringkasan Pemesanan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'InclusiveSans',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24), // balance
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Hotel Card ──────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Foto
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/bumimajapahit.png',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 80,
                                    height: 80,
                                    color: const Color(0xFFFFF0EB),
                                    child: const Icon(Icons.hotel,
                                        color: Color(0xFFF1510C), size: 30),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.favorite,
                                    size: 13,
                                    color: Color(0xFFF1510C),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 14),

                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Diskon 20%',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFFF1510C),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'InclusiveSans',
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 13),
                                    const SizedBox(width: 3),
                                    Text(
                                      hotel['rating'] ?? '4.8',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'InclusiveSans',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  hotel['name'] ?? 'Hotel Majapahit',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'InclusiveSans',
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on,
                                        size: 11, color: Colors.grey),
                                    const SizedBox(width: 2),
                                    Text(
                                      hotel['location'] ?? 'Surabaya Pusat',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                        fontFamily: 'InclusiveSans',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Rp850',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFFF1510C),
                                          fontFamily: 'InclusiveSans',
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' /Malam',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                          fontFamily: 'InclusiveSans',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Detail Pemesanan ──────────────────────────
                    _buildRow('Tanggal Pemesanan', '24 September 2023 | 14.00'),
                    const SizedBox(height: 10),
                    _buildRow('Check In', '10 November  2023'),
                    const SizedBox(height: 10),
                    _buildRow('Check Out', '04 December 2023'),
                    const SizedBox(height: 10),
                    _buildRow('Tamu', '${guests.toString().padLeft(2, '0')} Orang'),

                    const SizedBox(height: 20),
                    Divider(color: Colors.grey.shade200, height: 1),
                    const SizedBox(height: 20),

                    // ── Rincian Harga ─────────────────────────────
                    _buildRow('Jumlah', _formatRupiah(basePrice)),
                    const SizedBox(height: 10),
                    _buildRow('Pajak & Biaya', _formatRupiah(tax)),
                    const SizedBox(height: 10),
                    _buildRow('Total', _formatRupiah(total)),

                    const SizedBox(height: 20),
                    Divider(color: Colors.grey.shade200, height: 1),
                    const SizedBox(height: 20),

                    // ── Metode Pembayaran ─────────────────────────
                    Row(
                      children: [
                        Icon(Icons.credit_card,
                            size: 20, color: Colors.grey.shade600),
                        const SizedBox(width: 8),
                        Text(
                          'Kartu Debit',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            fontFamily: 'InclusiveSans',
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pilih metode pembayaran lain'),
                                backgroundColor: Color(0xFFF1510C),
                              ),
                            );
                          },
                          child: const Text(
                            'Ganti',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFF1510C),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'InclusiveSans',
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // ── Bottom Button ────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const OrderPlacedScreen()),
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
                    'Bayar Sekarang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'InclusiveSans',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade500,
            fontFamily: 'InclusiveSans',
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            fontFamily: 'InclusiveSans',
          ),
        ),
      ],
    );
  }
}