import 'package:flutter/material.dart';
import 'booking_screen.dart';

class SelectGuestSheet extends StatefulWidget {
  final int initialAdult;
  final int initialChild;
  final int initialBaby;
  final Map<String, dynamic> hotel;

  const SelectGuestSheet({
    super.key,
    this.initialAdult = 1,
    this.initialChild = 0,
    this.initialBaby = 0,
    required this.hotel,
  });

  @override
  State<SelectGuestSheet> createState() => _SelectGuestSheetState();
}

class _SelectGuestSheetState extends State<SelectGuestSheet> {
  late int _adult;
  late int _child;
  late int _baby;

  @override
  void initState() {
    super.initState();
    _adult = widget.initialAdult;
    _child = widget.initialChild;
    _baby = widget.initialBaby;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          const Text(
            'Pilih Tamu',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              fontFamily: 'InclusiveSans',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 24),

          _buildGuestRow(
            title: 'Dewasa',
            subtitle: 'Usia 18 tahun ke atas',
            count: _adult,
            onDecrement: () { if (_adult > 1) setState(() => _adult--); },
            onIncrement: () => setState(() => _adult++),
          ),
          const SizedBox(height: 22),

          _buildGuestRow(
            title: 'Anak-anak',
            subtitle: 'Usia 2–17 tahun',
            count: _child,
            onDecrement: () { if (_child > 0) setState(() => _child--); },
            onIncrement: () => setState(() => _child++),
          ),
          const SizedBox(height: 22),

          _buildGuestRow(
            title: 'Bayi',
            subtitle: 'Di bawah usia 2 tahun',
            count: _baby,
            onDecrement: () { if (_baby > 0) setState(() => _baby--); },
            onIncrement: () => setState(() => _baby++),
          ),
          const SizedBox(height: 30),

          // Tombol Lanjutkan paling bawah
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                // 1. Kirim data balik dan tutup sheet-nya
                Navigator.pop(context, {
                  'adult': _adult,
                  'child': _child,
                  'baby': _baby,
                  'total': _adult + _child + _baby,
                });

                // 2. LANGSUNG pindah ke halaman Booking (Ringkasan)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(hotel: widget.hotel),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF1510C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Lanjutkan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestRow({
    required String title,
    required String subtitle,
    required int count,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'InclusiveSans',
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontFamily: 'InclusiveSans',
                ),
              ),
            ],
          ),
        ),
        // Counter — (abu) angka + (orange)
        Row(
          children: [
            GestureDetector(
              onTap: onDecrement,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '−',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w300,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 16,
              child: Text(
                '$count',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'InclusiveSans',
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: onIncrement,
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1510C),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}