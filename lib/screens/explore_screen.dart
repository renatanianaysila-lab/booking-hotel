import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;
  int _selectedNavIndex = 1;

  final List<String> _categories = [
    'Semua',
    'Jakarta',
    'Bali',
    'Surabaya',
    'Bandung',
    'Yogyakarta',
    'Makassar',
    'Medan',
  ];

  final List<Map<String, dynamic>> _allHotels = [
    {
      'name': 'Hotel Majapahit',
      'location': 'Surabaya, Jawa Timur',
      'price': 'Rp 850.000',
      'rating': 4.8,
      'image': 'assets/bumimajapahit.png',
      'category': 'Surabaya',
      'tag': 'Rekomendasi',
    },
    {
      'name': 'Bumi Surabaya City Resort',
      'location': 'Surabaya, Jawa Timur',
      'price': 'Rp 1.200.000',
      'rating': 4.9,
      'image': 'assets/bumisurabaaya.png',
      'category': 'Surabaya',
      'tag': 'Populer',
    },
    {
      'name': 'Ciputra World Hotel',
      'location': 'Surabaya, Jawa Timur',
      'price': 'Rp 750.000',
      'rating': 4.6,
      'image': 'assets/ciputra.png',
      'category': 'Surabaya',
      'tag': '',
    },
    {
      'name': 'The Westin Jakarta',
      'location': 'Jakarta Selatan, DKI Jakarta',
      'price': 'Rp 2.100.000',
      'rating': 4.9,
      'image': 'assets/bumimajapahit.png',
      'category': 'Jakarta',
      'tag': 'Mewah',
    },
    {
      'name': 'Grand Mercure Bandung',
      'location': 'Bandung, Jawa Barat',
      'price': 'Rp 980.000',
      'rating': 4.7,
      'image': 'assets/bumisurabaaya.png',
      'category': 'Bandung',
      'tag': '',
    },
    {
      'name': 'Padma Resort Bali',
      'location': 'Legian, Bali',
      'price': 'Rp 3.500.000',
      'rating': 5.0,
      'image': 'assets/ciputra.png',
      'category': 'Bali',
      'tag': 'Terbaik',
    },
    {
      'name': 'Tentrem Hotel',
      'location': 'Yogyakarta',
      'price': 'Rp 1.100.000',
      'rating': 4.8,
      'image': 'assets/bumimajapahit.png',
      'category': 'Yogyakarta',
      'tag': '',
    },
    {
      'name': 'Four Points by Sheraton',
      'location': 'Makassar, Sulawesi Selatan',
      'price': 'Rp 890.000',
      'rating': 4.6,
      'image': 'assets/bumisurabaaya.png',
      'category': 'Makassar',
      'tag': '',
    },
    {
      'name': 'Harper Perintis',
      'location': 'Medan, Sumatera Utara',
      'price': 'Rp 720.000',
      'rating': 4.5,
      'image': 'assets/ciputra.png',
      'category': 'Medan',
      'tag': '',
    },
  ];

  List<Map<String, dynamic>> get _filteredHotels {
    final category = _categories[_selectedCategoryIndex];
    String query = _searchController.text.toLowerCase();

    return _allHotels.where((hotel) {
      final matchesCategory =
          category == 'Semua' || hotel['category'] == category;
      final matchesSearch = query.isEmpty ||
          hotel['name'].toString().toLowerCase().contains(query) ||
          hotel['location'].toString().toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jelajahi Hotel',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'InclusiveSans',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Temukan hotel impianmu di seluruh Indonesia',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'InclusiveSans',
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Search Bar
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      style: const TextStyle(
                        fontFamily: 'InclusiveSans',
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Cari hotel atau kota...',
                        hintStyle: const TextStyle(
                          fontFamily: 'InclusiveSans',
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        prefixIcon: Image.asset(
                          'assets/cari.png',
                          width: 20,
                          height: 20,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Category Filter
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () =>
                        setState(() => _selectedCategoryIndex = index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFF1510C)
                            : const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _categories[index],
                        style: TextStyle(
                          fontFamily: 'InclusiveSans',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black54,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Map Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xFFFFF0EB),
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/peta.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFFFFF0EB),
                          child: const Center(
                            child: Icon(
                              Icons.map_outlined,
                              size: 50,
                              color: Color(0xFFF1510C),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1510C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/mdi_location.png',
                              width: 16,
                              height: 16,
                              color: Colors.white,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Lihat di Peta',
                              style: TextStyle(
                                fontFamily: 'InclusiveSans',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
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

            const SizedBox(height: 16),

            // Hotel List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_filteredHotels.length} Hotel Ditemukan',
                    style: const TextStyle(
                      fontFamily: 'InclusiveSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: _filteredHotels.isEmpty
                  ? const Center(
                      child: Text(
                        'Tidak ada hotel ditemukan',
                        style: TextStyle(
                          fontFamily: 'InclusiveSans',
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _filteredHotels.length,
                      itemBuilder: (context, index) {
                        final hotel = _filteredHotels[index];
                        return _buildHotelCard(hotel);
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
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
            child: Image.asset(
              hotel['image'],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 100,
                height: 100,
                color: const Color(0xFFFFF0EB),
                child: const Icon(
                  Icons.hotel,
                  color: Color(0xFFF1510C),
                  size: 40,
                ),
              ),
            ),
          ),
          // Info
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hotel['tag'] != null && hotel['tag'].isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF0EB),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        hotel['tag'],
                        style: const TextStyle(
                          fontFamily: 'InclusiveSans',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF1510C),
                        ),
                      ),
                    ),
                  Text(
                    hotel['name'],
                    style: const TextStyle(
                      fontFamily: 'InclusiveSans',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
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
                            fontFamily: 'InclusiveSans',
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hotel['price'],
                        style: const TextStyle(
                          fontFamily: 'InclusiveSans',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF1510C),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 13,
                            color: Color(0xFFF1510C),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            hotel['rating'].toString(),
                            style: const TextStyle(
                              fontFamily: 'InclusiveSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
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
      {'icon': 'assets/home.png',         'label': 'Beranda',  'fallback': Icons.home},
      {'icon': 'assets/mdi_location.png', 'label': 'Jelajahi', 'fallback': Icons.explore_outlined},
      {'icon': 'assets/heart.png',        'label': 'Favorit',  'fallback': Icons.favorite_border},
      {'icon': 'assets/Group.png',        'label': 'Profil',   'fallback': Icons.person_outline},
    ];

    return Container(
      height: 70,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = _selectedNavIndex == index;
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()));
              } else if (index == 2) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const FavoriteScreen()));
              } else if (index == 3) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()));
              } else {
                setState(() => _selectedNavIndex = index);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  items[index]['icon'] as String,
                  width: 24,
                  height: 24,
                  color: isSelected
                      ? const Color(0xFFF1510C)
                      : Colors.grey,
                  errorBuilder: (_, __, ___) => Icon(
                    items[index]['fallback'] as IconData,
                    size: 24,
                    color: isSelected
                        ? const Color(0xFFF1510C)
                        : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  items[index]['label'] as String,
                  style: TextStyle(
                    fontFamily: 'InclusiveSans',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? const Color(0xFFF1510C)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}