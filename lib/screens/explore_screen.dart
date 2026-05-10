import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';
import 'detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _currentIndex = 1;
  String _selectedCity = 'Semua';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> _cities = [
    'Semua', 'Jakarta', 'Bali', 'Surabaya', 'Bandung', 'Yogyakarta'
  ];

  final List<Map<String, dynamic>> _hotels = [
    {
      'name': 'Hotel Majapahit',
      'location': 'Surabaya, Jawa Timur',
      'city': 'Surabaya',
      'price': 'Rp850.000',
      'rating': '4.8',
      'reviews': '107',
      'image': 'assets/Rectangle 11.png',
      'badge': 'Rekomendasi',
      'badgeColor': Color(0xFF4CAF50),
      'discount': 'Diskon 20%',
      'beds': 2,
      'bathrooms': 1,
      'area': 2000,
      'description':
          'Hotel bersejarah di jantung Surabaya dengan kolam renang mewah, restoran, dan fasilitas lengkap. Dekat dengan pusat perbelanjaan dan objek wisata kota.',
    },
    {
      'name': 'Bumi Surabaya City Resort',
      'location': 'Surabaya, Jawa Timur',
      'city': 'Surabaya',
      'price': 'Rp1.200.000',
      'rating': '4.9',
      'reviews': '213',
      'image': 'assets/Rectangle 12.png',
      'badge': 'Populer',
      'badgeColor': Color(0xFF2196F3),
      'discount': 'Diskon 15%',
      'beds': 2,
      'bathrooms': 2,
      'area': 2500,
      'description':
          'Resort mewah di pusat kota Surabaya dengan pemandangan indah, fasilitas spa, kolam renang infinity, dan restoran rooftop.',
    },
    {
      'name': 'Ciputra World Hotel',
      'location': 'Surabaya, Jawa Timur',
      'city': 'Surabaya',
      'price': 'Rp750.000',
      'rating': '4.6',
      'reviews': '89',
      'image': 'assets/Rectangle 13.png',
      'badge': null,
      'badgeColor': null,
      'discount': 'Diskon 10%',
      'beds': 1,
      'bathrooms': 1,
      'area': 1800,
      'description':
          'Hotel modern terintegrasi dengan pusat perbelanjaan Ciputra World. Lokasi strategis dan akses mudah ke berbagai fasilitas hiburan.',
    },
    {
      'name': 'The Westin Jakarta',
      'location': 'Jakarta Selatan, DKI Jakarta',
      'city': 'Jakarta',
      'price': 'Rp1.500.000',
      'rating': '4.9',
      'reviews': '312',
      'image': 'assets/Rectangle 14.png',
      'badge': 'Mewah',
      'badgeColor': Color(0xFF9C27B0),
      'discount': 'Diskon 10%',
      'beds': 2,
      'bathrooms': 2,
      'area': 3200,
      'description':
          'Hotel bintang 5 di jantung Jakarta Selatan dengan fasilitas world-class, spa eksklusif, dan pemandangan kota yang memukau.',
    },
    {
      'name': 'The Trans Resort Bali',
      'location': 'Seminyak, Bali',
      'city': 'Bali',
      'price': 'Rp2.000.000',
      'rating': '4.8',
      'reviews': '428',
      'image': 'assets/Rectangle 15.png',
      'badge': 'Rekomendasi',
      'badgeColor': Color(0xFF4CAF50),
      'discount': 'Diskon 25%',
      'beds': 2,
      'bathrooms': 2,
      'area': 4500,
      'description':
          'Resort mewah tepi pantai Seminyak dengan kolam renang tak terbatas, restoran tepi pantai, dan pemandangan matahari terbenam yang memukau.',
    },
    {
      'name': 'Padma Hotel Bandung',
      'location': 'Dago, Bandung',
      'city': 'Bandung',
      'price': 'Rp900.000',
      'rating': '4.7',
      'reviews': '156',
      'image': 'assets/Rectangle 16.png',
      'badge': 'Populer',
      'badgeColor': Color(0xFF2196F3),
      'discount': 'Diskon 12%',
      'beds': 1,
      'bathrooms': 1,
      'area': 2200,
      'description':
          'Hotel butik di kawasan Dago Bandung dengan nuansa tropis dan pemandangan pegunungan. Sempurna untuk liburan keluarga.',
    },
  ];

  List<Map<String, dynamic>> get _filteredHotels {
    return _hotels.where((h) {
      final matchCity =
          _selectedCity == 'Semua' || h['city'] == _selectedCity;
      final matchSearch = _searchQuery.isEmpty ||
          (h['name'] as String)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          (h['location'] as String)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      return matchCity && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredHotels;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jelajahi Hotel',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'InclusiveSans',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Temukan hotel impianmu di seluruh Indonesia',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontFamily: 'InclusiveSans',
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _searchQuery = v),
                      style: const TextStyle(
                        fontFamily: 'InclusiveSans',
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Cari hotel atau kota...',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'InclusiveSans',
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.search,
                            color: Colors.grey, size: 20),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.grey, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _searchQuery = '');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _cities.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final city = _cities[index];
                  final isSelected = _selectedCity == city;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCity = city),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFF1510C)
                            : const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        city,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'InclusiveSans',
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 14),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/peta.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFFE8E8E8),
                          child: const Center(
                            child: Icon(Icons.map,
                                size: 40, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1510C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Lihat di Peta',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'InclusiveSans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    '${filtered.length} Hotel Ditemukan',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'InclusiveSans',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: filtered.isEmpty
                  ? const Center(
                      child: Text(
                        'Hotel tidak ditemukan',
                        style: TextStyle(
                          fontFamily: 'InclusiveSans',
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return _buildHotelCard(filtered[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHotelCard(Map<String, dynamic> hotel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(hotel: hotel),
          ),
        );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  hotel['image'] as String,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFE8E8E8),
                    child:
                        const Icon(Icons.hotel, size: 30, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (hotel['badge'] != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            margin: const EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                              color: (hotel['badgeColor'] as Color)
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              hotel['badge'] as String,
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'InclusiveSans',
                                fontWeight: FontWeight.w600,
                                color: hotel['badgeColor'] as Color,
                              ),
                            ),
                          ),
                        Text(
                          hotel['name'] as String,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'InclusiveSans',
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 11, color: Colors.grey),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                hotel['location'] as String,
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
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          hotel['price'] as String,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'InclusiveSans',
                            color: Color(0xFFF1510C),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.star,
                            color: Color(0xFFFFC107), size: 13),
                        const SizedBox(width: 2),
                        Text(
                          '${hotel['rating']}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'InclusiveSans',
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': 'assets/home.png', 'label': 'Beranda', 'fallback': Icons.home},
      {
        'icon': 'assets/mdi_location.png',
        'label': 'Jelajahi',
        'fallback': Icons.explore_outlined
      },
      {
        'icon': 'assets/heart.png',
        'label': 'Favorit',
        'fallback': Icons.favorite_border
      },
      {
        'icon': 'assets/Group.png',
        'label': 'Profil',
        'fallback': Icons.person_outline
      },
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
                    setState(() => _currentIndex = index);
                  } else if (index == 2) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FavoriteScreen()));
                  } else if (index == 3) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ProfileScreen()));
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      item['icon'] as String,
                      width: 24,
                      height: 24,
                      color: isActive
                          ? const Color(0xFFF1510C)
                          : Colors.grey,
                      errorBuilder: (_, __, ___) => Icon(
                        item['fallback'] as IconData,
                        size: 24,
                        color: isActive
                            ? const Color(0xFFF1510C)
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'InclusiveSans',
                        color: isActive
                            ? const Color(0xFFF1510C)
                            : Colors.grey,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
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