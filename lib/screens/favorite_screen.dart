import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'explore_screen.dart';
import 'profile_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _currentIndex = 2;

  final List<Map<String, dynamic>> _favorites = [
    {
      'image': 'assets/ciputra.png',
      'name': 'Ciputra World Hotel',
      'location': 'Surabaya, Jawa Timur',
      'price': 'Rp1,1jt',
      'rating': '4.8',
      'discount': '10% Off',
      'isFavorite': true,
    },
    {
      'image': 'assets/bumisurabaaya.png',
      'name': 'Four Points by Sheraton',
      'location': 'Makassar, Sulawesi Selatan',
      'price': 'Rp1,2jt',
      'rating': '4.9',
      'discount': '20% Off',
      'isFavorite': true,
    },
    {
      'image': 'assets/bumimajapahit.png',
      'name': 'Hotel Majapahit',
      'location': 'Surabaya, Jawa Timur',
      'price': 'Rp850rb',
      'rating': '4.8',
      'discount': 'Diskon 20%',
      'isFavorite': true,
    },
    {
      'image': 'assets/other.png',
      'name': 'Padma Resort Bali',
      'location': 'Legian, Bali',
      'price': 'Rp2,1jt',
      'rating': '4.6',
      'discount': '5% Off',
      'isFavorite': true,
    },
  ];

  void _toggleFavorite(int index) {
    setState(() {
      _favorites.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Dihapus dari favorit',
          style: TextStyle(fontFamily: 'InclusiveSans'),
        ),
        backgroundColor: Color(0xFFF1510C),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Text(
                'Favorit Saya',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'InclusiveSans',
                  color: Colors.black,
                ),
              ),
            ),

            if (_favorites.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/heart.png',
                        width: 70,
                        height: 70,
                        color: Colors.grey.shade300,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.favorite_border,
                          size: 70,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Belum ada hotel favorit',
                        style: TextStyle(
                          fontFamily: 'InclusiveSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tekan ❤️ pada hotel untuk\nmenambahkan ke favorit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'InclusiveSans',
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _favorites.length,
                  itemBuilder: (context, index) {
                    final hotel = _favorites[index];
                    return _buildFavoriteCard(hotel, index);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> hotel, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
          // Gambar
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
                child: Image.asset(
                  hotel['image'],
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 110,
                    height: 110,
                    color: const Color(0xFFFFF0EB),
                    child: const Icon(Icons.hotel, color: Color(0xFFF1510C), size: 40),
                  ),
                ),
              ),
              // Tombol hapus favorit
              Positioned(
                top: 8,
                left: 8,
                child: GestureDetector(
                  onTap: () => _toggleFavorite(index),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/heart.png',
                      width: 16,
                      height: 16,
                      color: const Color(0xFFF1510C),
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.favorite,
                        size: 16,
                        color: Color(0xFFF1510C),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hotel['discount'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFFF1510C),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'InclusiveSans',
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 13),
                          const SizedBox(width: 2),
                          Text(
                            hotel['rating'],
                            style: const TextStyle(
                              fontSize: 11,
                              fontFamily: 'InclusiveSans',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    hotel['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'InclusiveSans',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Image.asset(
                        'assets/lokasi.png',
                        width: 12,
                        height: 12,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.location_on,
                          size: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          hotel['location'],
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontFamily: 'InclusiveSans',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: hotel['price'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF1510C),
                            fontFamily: 'InclusiveSans',
                          ),
                        ),
                        const TextSpan(
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
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': 'assets/home.png',          'label': 'Beranda',  'fallback': Icons.home},
      {'icon': 'assets/mdi_location.png',  'label': 'Jelajahi', 'fallback': Icons.explore_outlined},
      {'icon': 'assets/heart.png',         'label': 'Favorit',  'fallback': Icons.favorite_border},
      {'icon': 'assets/Group.png',         'label': 'Profil',   'fallback': Icons.person_outline},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
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
                  } else if (index == 3) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const ProfileScreen()));
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