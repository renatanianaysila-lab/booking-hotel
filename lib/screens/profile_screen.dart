import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'explore_screen.dart';
import 'favorite_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3;

  final Map<String, dynamic> _user = {
    'name': 'Naysila Renatania',
    'email': 'naysila@email.com',
    'phone': '+62 812-3456-7890',
    'joinDate': 'Mei 2026',
    'totalBooking': 5,
  };

  void _logout() async {
    if (!mounted) return;
    Navigator.of(context).pop();
    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                decoration: const BoxDecoration(
                  color: Color(0xFFF1510C),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Profil Saya',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'InclusiveSans',
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/Group.png',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.person,
                            size: 50,
                            color: Color(0xFFF1510C),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _user['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'InclusiveSans',
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _user['email'],
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'InclusiveSans',
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.hotel, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            '${_user['totalBooking']} Pemesanan',
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'InclusiveSans',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.calendar_today,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Sejak ${_user['joinDate']}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'InclusiveSans',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              _buildSectionTitle('Informasi Akun'),
              _buildInfoTile(Icons.person_outline, 'Nama', _user['name']),
              _buildInfoTile(Icons.email_outlined, 'Email', _user['email']),
              _buildInfoTile(Icons.phone_outlined, 'Nomor HP', _user['phone']),

              const SizedBox(height: 16),

              _buildSectionTitle('Pengaturan'),
              _buildMenuTile(Icons.notifications_outlined, 'Notifikasi'),
              _buildMenuTile(Icons.lock_outline, 'Ubah Kata Sandi'),
              _buildMenuTile(Icons.language_outlined, 'Bahasa'),
              _buildMenuTile(Icons.help_outline, 'Bantuan & FAQ'),
              _buildMenuTile(Icons.info_outline, 'Tentang Aplikasi'),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext dialogContext) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: const Text(
                          'Keluar',
                          style: TextStyle(
                            fontFamily: 'InclusiveSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        content: const Text(
                          'Apakah kamu yakin ingin keluar?',
                          style: TextStyle(fontFamily: 'InclusiveSans'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            child: const Text(
                              'Batal',
                              style: TextStyle(
                                fontFamily: 'InclusiveSans',
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: _logout,
                            child: const Text(
                              'Keluar',
                              style: TextStyle(
                                fontFamily: 'InclusiveSans',
                                color: Color(0xFFF1510C),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFF1510C)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Color(0xFFF1510C), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Keluar',
                          style: TextStyle(
                            fontFamily: 'InclusiveSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFF1510C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          fontFamily: 'InclusiveSans',
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFFF1510C)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontFamily: 'InclusiveSans',
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'InclusiveSans',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFFF1510C)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'InclusiveSans',
                color: Colors.black,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': 'assets/home.png',         'label': 'Beranda',  'fallback': Icons.home},
      {'icon': 'assets/mdi_location.png', 'label': 'Jelajahi', 'fallback': Icons.explore_outlined},
      {'icon': 'assets/heart.png',        'label': 'Favorit',  'fallback': Icons.favorite_border},
      {'icon': 'assets/Group.png',        'label': 'Profil',   'fallback': Icons.person_outline},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isActive = _currentIndex == index;
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()));
                  } else if (index == 1) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const ExploreScreen()));
                  } else if (index == 2) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const FavoriteScreen()));
                  } else {
                    setState(() => _currentIndex = index);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      item['icon'] as String,
                      width: 24,
                      height: 24,
                      color: isActive ? const Color(0xFFF1510C) : Colors.grey,
                      errorBuilder: (_, __, ___) => Icon(
                        item['fallback'] as IconData,
                        size: 24,
                        color: isActive ? const Color(0xFFF1510C) : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'InclusiveSans',
                        color: isActive ? const Color(0xFFF1510C) : Colors.grey,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}