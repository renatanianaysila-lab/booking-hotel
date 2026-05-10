import 'package:flutter/material.dart';
import 'explore_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _rekomendasiHotels = [
    {
      'image': 'assets/bumimajapahit.png',
      'discount': 'Diskon 20%',
      'rating': '4.8',
      'name': 'Hotel Majapahit',
      'location': 'Surabaya, Jawa Timur',
      'price': 'Rp850rb',
      'isFavorite': false,
    },
    {
      'image': 'assets/bumisurabaaya.png',
      'discount': '10% Off',
      'rating': '4.7',
      'name': 'Bumi Surabaya City Resort',
      'location': 'Surabaya, Jawa Timur',
      'price': 'Rp720rb',
      'isFavorite': false,
    },
    {
      'image': 'assets/ciputra.png',
      'discount': '15% Off',
      'rating': '4.9',
      'name': 'The Westin Jakarta',
      'location': 'Jakarta Selatan, DKI Jakarta',
      'price': 'Rp1,5jt',
      'isFavorite': false,
    },
    {
      'image': 'assets/other.png',
      'discount': '5% Off',
      'rating': '4.6',
      'name': 'Padma Resort Bali',
      'location': 'Legian, Bali',
      'price': 'Rp2,1jt',
      'isFavorite': false,
    },
  ];

  final List<Map<String, dynamic>> _terdekatHotels = [
    {
      'image': 'assets/ciputra.png',
      'discount': '10% Off',
      'rating': '4.8',
      'name': 'Ciputra World Hotel',
      'location': 'Surabaya, Jawa Timur',
      'price': 'Rp1,1jt',
      'isFavorite': true,
    },
    {
      'image': 'assets/other.png',
      'discount': '12% Off',
      'rating': '4.5',
      'name': 'Grand Mercure Bandung',
      'location': 'Bandung, Jawa Barat',
      'price': 'Rp950rb',
      'isFavorite': false,
    },
    {
      'image': 'assets/bumimajapahit.png',
      'discount': '8% Off',
      'rating': '4.7',
      'name': 'Tentrem Hotel Yogyakarta',
      'location': 'Yogyakarta, DIY',
      'price': 'Rp880rb',
      'isFavorite': false,
    },
    {
      'image': 'assets/bumisurabaaya.png',
      'discount': '20% Off',
      'rating': '4.9',
      'name': 'Four Points by Sheraton',
      'location': 'Makassar, Sulawesi Selatan',
      'price': 'Rp1,2jt',
      'isFavorite': true,
    },
    {
      'image': 'assets/ciputra.png',
      'discount': '10% Off',
      'rating': '4.6',
      'name': 'Swiss-Belhotel Borneo',
      'location': 'Balikpapan, Kalimantan Timur',
      'price': 'Rp780rb',
      'isFavorite': false,
    },
    {
      'image': 'assets/other.png',
      'discount': '7% Off',
      'rating': '4.8',
      'name': 'Harper Perintis Medan',
      'location': 'Medan, Sumatera Utara',
      'price': 'Rp650rb',
      'isFavorite': false,
    },
  ];

  void _goToExplore() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const ExploreScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSearchBar(),
              const SizedBox(height: 24),
              _buildSectionHeader('Hotel Rekomendasi'),
              const SizedBox(height: 12),
              _buildRekomendasiList(),
              const SizedBox(height: 24),
              _buildSectionHeader('Hotel Terdekat'),
              const SizedBox(height: 12),
              _buildTerdekatList(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/lokasi.png', width: 22, height: 22,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.location_on, color: Color(0xFFF1510C), size: 22)),
              const SizedBox(width: 6),
              const Text('Surabaya, Jawa Timur',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'InclusiveSans')),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black),
            ],
          ),
          Image.asset('assets/notif.png', width: 36, height: 36,
              errorBuilder: (_, __, ___) => Container(
                width: 36, height: 36,
                decoration: const BoxDecoration(color: Color(0xFFF1510C), shape: BoxShape.circle),
                child: const Icon(Icons.notifications, color: Colors.white, size: 20),
              )),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: _goToExplore,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: const Color(0xFFFFF3EE), borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              const SizedBox(width: 14),
              Image.asset('assets/cari.png', width: 20, height: 20,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.search, color: Colors.grey, size: 20)),
              const SizedBox(width: 10),
              const Text('Cari hotel...',
                  style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'InclusiveSans')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w700, fontFamily: 'InclusiveSans')),
          GestureDetector(
            onTap: _goToExplore,
            child: const Text('Lihat Semua',
                style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFF1510C),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'InclusiveSans')),
          ),
        ],
      ),
    );
  }

  Widget _buildRekomendasiList() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _rekomendasiHotels.length,
        itemBuilder: (context, index) =>
            _buildRekomendasiCard(_rekomendasiHotels[index], index),
      ),
    );
  }

  Widget _buildRekomendasiCard(Map<String, dynamic> hotel, int index) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.asset(hotel['image'], height: 110, width: double.infinity, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                        height: 110,
                        color: Colors.orange.shade100,
                        child: const Icon(Icons.hotel, size: 40, color: Color(0xFFF1510C)))),
              ),
              Positioned(
                top: 8, right: 8,
                child: GestureDetector(
                  onTap: () => setState(() =>
                      _rekomendasiHotels[index]['isFavorite'] =
                          !_rekomendasiHotels[index]['isFavorite']),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Image.asset('assets/heart.png', width: 16, height: 16,
                        color: hotel['isFavorite'] ? const Color(0xFFF1510C) : Colors.grey,
                        errorBuilder: (_, __, ___) => Icon(
                            hotel['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                            size: 16,
                            color: hotel['isFavorite'] ? const Color(0xFFF1510C) : Colors.grey)),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(hotel['discount'],
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFFF1510C), fontWeight: FontWeight.w500, fontFamily: 'InclusiveSans')),
                  Row(children: [
                    const Icon(Icons.star, color: Colors.amber, size: 13),
                    const SizedBox(width: 2),
                    Text(hotel['rating'], style: const TextStyle(fontSize: 11, fontFamily: 'InclusiveSans')),
                  ]),
                ]),
                const SizedBox(height: 4),
                Text(hotel['name'],
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'InclusiveSans'),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.location_on, size: 12, color: Colors.grey),
                  const SizedBox(width: 2),
                  Expanded(
                      child: Text(hotel['location'],
                          style: const TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'InclusiveSans'),
                          maxLines: 1, overflow: TextOverflow.ellipsis)),
                ]),
                const SizedBox(height: 4),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: hotel['price'],
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFFF1510C), fontFamily: 'InclusiveSans')),
                  const TextSpan(text: ' /Malam',
                      style: TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'InclusiveSans')),
                ])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerdekatList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _terdekatHotels.length,
      itemBuilder: (context, index) =>
          _buildTerdekatCard(_terdekatHotels[index], index),
    );
  }

  Widget _buildTerdekatCard(Map<String, dynamic> hotel, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(14)),
                child: Image.asset(hotel['image'], width: 110, height: 110, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                        width: 110, height: 110,
                        decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(14))),
                        child: const Icon(Icons.hotel, size: 40, color: Color(0xFFF1510C)))),
              ),
              Positioned(
                top: 8, left: 8,
                child: GestureDetector(
                  onTap: () => setState(() =>
                      _terdekatHotels[index]['isFavorite'] =
                          !_terdekatHotels[index]['isFavorite']),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Image.asset('assets/heart.png', width: 16, height: 16,
                        color: hotel['isFavorite'] ? const Color(0xFFF1510C) : Colors.grey,
                        errorBuilder: (_, __, ___) => Icon(
                            hotel['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                            size: 16,
                            color: hotel['isFavorite'] ? const Color(0xFFF1510C) : Colors.grey)),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(hotel['discount'],
                        style: const TextStyle(
                            fontSize: 11, color: Color(0xFFF1510C), fontWeight: FontWeight.w500, fontFamily: 'InclusiveSans')),
                    Row(children: [
                      const Icon(Icons.star, color: Colors.amber, size: 13),
                      const SizedBox(width: 2),
                      Text(hotel['rating'], style: const TextStyle(fontSize: 11, fontFamily: 'InclusiveSans')),
                    ]),
                  ]),
                  const SizedBox(height: 6),
                  Text(hotel['name'],
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'InclusiveSans'),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.location_on, size: 12, color: Colors.grey),
                    const SizedBox(width: 2),
                    Expanded(
                        child: Text(hotel['location'],
                            style: const TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'InclusiveSans'),
                            maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ]),
                  const SizedBox(height: 6),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(text: hotel['price'],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFF1510C), fontFamily: 'InclusiveSans')),
                    const TextSpan(text: ' /Malam',
                        style: TextStyle(fontSize: 11, color: Colors.grey, fontFamily: 'InclusiveSans')),
                  ])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
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
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, -2))
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
                  if (index == 1) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const ExploreScreen()));
                  } else if (index == 2) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const FavoriteScreen()));
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
                    Image.asset(item['icon'] as String, width: 24, height: 24,
                        color: isActive ? const Color(0xFFF1510C) : Colors.grey,
                        errorBuilder: (_, __, ___) => Icon(item['fallback'] as IconData,
                            size: 24, color: isActive ? const Color(0xFFF1510C) : Colors.grey)),
                    const SizedBox(height: 4),
                    Text(item['label'] as String,
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'InclusiveSans',
                            color: isActive ? const Color(0xFFF1510C) : Colors.grey,
                            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400)),
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