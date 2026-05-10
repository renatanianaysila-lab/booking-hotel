import 'package:flutter/material.dart';
import 'booking_summary_screen.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> hotel;

  const BookingScreen({super.key, required this.hotel});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _selectedCheckIn = 0;
  int _selectedCheckOut = 0;
  final TextEditingController _noteController = TextEditingController();

  // Tanggal hardcode sesuai foto: check-in mulai "Hari ini 10 nov"
  final List<Map<String, String>> _checkInDates = [
    {'top': 'Hari ini', 'bottom': '10 nov'},
    {'top': 'Senin',    'bottom': '11 nov'},
    {'top': 'Selasa',   'bottom': '12 nov'},
    {'top': 'Rabu',     'bottom': '13 nov'},
    {'top': 'Kamis',    'bottom': '14 nov'},
    {'top': 'Jumat',    'bottom': '15 nov'},
  ];

  final List<Map<String, String>> _checkOutDates = [
    {'top': 'Minggu', 'bottom': '4 Dec'},
    {'top': 'Senin',  'bottom': '5 Dec'},
    {'top': 'Selasa', 'bottom': '6 Dec'},
    {'top': 'Rabu',   'bottom': '7 Dec'},
    {'top': 'Kamis',  'bottom': '8 Dec'},
    {'top': 'Jumat',  'bottom': '9 Dec'},
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _lanjutkan() {
    final checkIn = _checkInDates[_selectedCheckIn]['bottom']!;
    final checkOut = _checkOutDates[_selectedCheckOut]['bottom']!;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingSummaryScreen(
          hotel: widget.hotel,
          checkIn: checkIn,
          checkOut: checkOut,
          guests: 5,
          notes: _noteController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // ── Hero Image ──────────────────────────
                Stack(
                  children: [
                    SizedBox(
                      height: 240,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/Rectangle 11.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFFE0E0E0),
                          child: const Icon(Icons.hotel,
                              size: 60, color: Colors.grey),
                        ),
                      ),
                    ),
                    // Back
                    Positioned(
                      top: 44,
                      left: 16,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new,
                              size: 16, color: Colors.black),
                        ),
                      ),
                    ),
                    // Favorite
                    Positioned(
                      top: 44,
                      right: 16,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.favorite_border,
                            size: 18, color: Colors.grey),
                      ),
                    ),
                  ],
                ),

                // ── White Content ────────────────────────
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge + rating
                      Row(
                        children: [
                          Text(
                            hotel['discount'] ?? 'Diskon 20%',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFFF1510C),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'InclusiveSans',
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.star,
                              color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            '${hotel['rating'] ?? '4.8'} (${hotel['reviews'] ?? '107'} ulasan)',
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'InclusiveSans',
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Hotel name
                      Text(
                        hotel['name'] ?? 'Hotel Majapahit',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'InclusiveSans',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Location
                      Text(
                        hotel['location'] ?? 'Surabaya Pusat',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontFamily: 'InclusiveSans',
                        ),
                      ),

                      const SizedBox(height: 20),
                      Divider(color: Colors.grey.shade200, height: 1),
                      const SizedBox(height: 16),

                      // Label "Pesan Hotel"
                      const Text(
                        'Pesan Hotel',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontFamily: 'InclusiveSans',
                        ),
                      ),
                      const SizedBox(height: 14),

                      // ── Check In ──────────────────────
                      const Text(
                        'Check in',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'InclusiveSans',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 62,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _checkInDates.length,
                          itemBuilder: (context, index) {
                            final d = _checkInDates[index];
                            final isSelected = _selectedCheckIn == index;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedCheckIn = index),
                              child: _buildDateChip(
                                top: d['top']!,
                                bottom: d['bottom']!,
                                isSelected: isSelected,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 18),

                      // ── Check Out ─────────────────────
                      const Text(
                        'Check out',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'InclusiveSans',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 62,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _checkOutDates.length,
                          itemBuilder: (context, index) {
                            final d = _checkOutDates[index];
                            final isSelected = _selectedCheckOut == index;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedCheckOut = index),
                              child: _buildDateChip(
                                top: d['top']!,
                                bottom: d['bottom']!,
                                isSelected: isSelected,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 22),

                      // ── Catatan untuk Pemilik ─────────
                      const Text(
                        'Catatan untuk Pemilik',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'InclusiveSans',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _noteController,
                        maxLines: 4,
                        style: const TextStyle(
                          fontFamily: 'InclusiveSans',
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Masukkan catatan di sini...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: 'InclusiveSans',
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFFFF5F1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom Button ────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              color: Colors.white,
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _lanjutkan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1510C),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Lanjutkan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'InclusiveSans',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip({
    required String top,
    required String bottom,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFF1510C)
            : const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            top,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'InclusiveSans',
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            bottom,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'InclusiveSans',
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}