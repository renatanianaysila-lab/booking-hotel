import 'package:flutter/material.dart';
import 'write_review_screen.dart';
import 'booking_screen.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> hotel;

  const DetailScreen({super.key, required this.hotel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFavorite = false;
  int _selectedImageIndex = 0;

  final List<String> _galleryImages = [
    'assets/Rectangle 11.png',
    'assets/Rectangle 12.png',
    'assets/Rectangle 13.png',
    'assets/Rectangle 14.png',
    'assets/Rectangle 15.png',
    'assets/Rectangle 16.png',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                Stack(
                  children: [
                    SizedBox(
                      height: 260,
                      width: double.infinity,
                      child: Image.asset(
                        _galleryImages[_selectedImageIndex],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFFE0E0E0),
                          child: const Icon(Icons.hotel,
                              size: 60, color: Colors.grey),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.4),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 44,
                      left: 16,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.arrow_back_ios_new,
                              size: 16, color: Colors.black),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 44,
                      right: 16,
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _isFavorite = !_isFavorite),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 18,
                            color: _isFavorite
                                ? const Color(0xFFF1510C)
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: SizedBox(
                    height: 58,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _galleryImages.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final isSelected = _selectedImageIndex == index;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedImageIndex = index),
                          child: Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFF1510C)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                _galleryImages[index],
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: const Color(0xFFE8E8E8),
                                  child: const Icon(Icons.image,
                                      size: 20, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1510C),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              hotel['discount'] ?? 'Diskon 20%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'InclusiveSans',
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.star,
                              color: Color(0xFFFFC107), size: 16),
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

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              hotel['name'] ?? 'Hotel Majapahit',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'InclusiveSans',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF1510C),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/Vector.png',
                                  color: Colors.white,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            hotel['location'] ?? 'Surabaya Pusat',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontFamily: 'InclusiveSans',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      TabBar(
                        controller: _tabController,
                        labelColor: const Color(0xFFF1510C),
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: const Color(0xFFF1510C),
                        indicatorWeight: 2.5,
                        labelStyle: const TextStyle(
                          fontFamily: 'InclusiveSans',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontFamily: 'InclusiveSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        tabs: const [
                          Tab(text: 'Tentang'),
                          Tab(text: 'Galeri'),
                          Tab(text: 'Ulasan'),
                        ],
                      ),

                      const SizedBox(height: 16),

                      AnimatedBuilder(
                        animation: _tabController,
                        builder: (context, _) {
                          switch (_tabController.index) {
                            case 0:
                              return _buildTentang(hotel);
                            case 1:
                              return _buildGaleri();
                            case 2:
                              return _buildUlasan();
                            default:
                              return _buildTentang(hotel);
                          }
                        },
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Harga per malam',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontFamily: 'InclusiveSans',
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: hotel['price'] ?? 'Rp850',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
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
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                     onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => BookingScreen(hotel: widget.hotel),
    ),
  );
},
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1510C),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/Vector.png',
                              width: 18,
                              height: 18,
                              color: Colors.white,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Pesan Sekarang',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'InclusiveSans',
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildTentang(Map<String, dynamic> hotel) {
    final facilities = [
      {
        'icon': 'assets/material-symbols_bed.png',
        'label': '${hotel['beds'] ?? 2} Kasur',
        'fallback': Icons.bed_outlined,
      },
      {
        'icon': 'assets/mdi_bathroom.png',
        'label': '${hotel['bathrooms'] ?? 1} Kamar Mandi',
        'fallback': Icons.bathtub_outlined,
      },
      {
        'icon': 'assets/carbon_area.png',
        'label': '${hotel['area'] ?? 2000} m²',
        'fallback': Icons.square_foot,
      },
      {
        'icon': 'assets/streamline_hotel-air-conditioner.png',
        'label': 'AC',
        'fallback': Icons.ac_unit,
      },
      {
        'icon': 'assets/tabler_wifi.png',
        'label': 'Wi-fi',
        'fallback': Icons.wifi,
      },
      {
        'icon': 'assets/fluent-mdl2_breakfast.png',
        'label': 'Sarapan',
        'fallback': Icons.restaurant,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: facilities.map((f) => _buildFacilityChip(f)).toList(),
        ),

        const SizedBox(height: 20),

        const Text(
          'Deskripsi',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'InclusiveSans',
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          hotel['description'] ??
              'Hotel bersejarah di jantung Surabaya dengan kolam renang mewah, restoran, dan fasilitas lengkap. Dekat dengan pusat perbelanjaan dan objek wisata kota.',
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
            fontFamily: 'InclusiveSans',
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildFacilityChip(Map<String, dynamic> f) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          Image.asset(
            f['icon'] as String,
            width: 18,
            height: 18,
            color: const Color(0xFFF1510C),
            errorBuilder: (_, __, ___) => Icon(
              f['fallback'] as IconData,
              size: 18,
              color: const Color(0xFFF1510C),
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              f['label'] as String,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'InclusiveSans',
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGaleri() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.2,
      children: _galleryImages.map((img) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            img,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: const Color(0xFFE8E8E8),
              child: const Icon(Icons.image, size: 40, color: Colors.grey),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUlasan() {
    final reviews = [
      {
        'name': 'John Dey',
        'rating': 5,
        'comment': 'Kamar bersih dan nyaman, pelayanan sangat baik!',
        'date': '10 bulan lalu',
      },
      {
        'name': 'Budi Santoso',
        'rating': 4,
        'comment': 'Lokasi strategis, dekat mall dan tempat wisata.',
        'date': '1 minggu lalu',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Ulasan',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: 'InclusiveSans',
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WriteReviewScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit_outlined,
                color: Color(0xFFF1510C),
                size: 18,
              ),
              label: const Text(
                'Tulis Ulasan',
                style: TextStyle(
                  color: Color(0xFFF1510C),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'InclusiveSans',
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        Container(
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF5F1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Cari Ulasan',
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xFFF1510C),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 12),
            ),
          ),
        ),

        const SizedBox(height: 14),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip('Filter'),
              _buildFilterChip('Terverifikasi'),
              _buildFilterChip('Terbaru'),
              _buildFilterChip('Dengan Foto'),
            ],
          ),
        ),

        const SizedBox(height: 18),

        ...reviews.map((r) {
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xFFF1510C).withValues(alpha: 0.15),
                  child: Text(
                    (r['name'] as String)[0],
                    style: const TextStyle(
                      color: Color(0xFFF1510C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            r['name'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'InclusiveSans',
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            r['date'] as String,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            Icons.star,
                            size: 14,
                            color: i < (r['rating'] as int)
                                ? Colors.amber
                                : Colors.grey.shade300,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        r['comment'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: Colors.black87,
                          fontFamily: 'InclusiveSans',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildFilterChip(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: text == 'Terverifikasi'
            ? const Color(0xFFF1510C)
            : const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: text == 'Terverifikasi'
              ? Colors.white
              : Colors.black87,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'InclusiveSans',
        ),
      ),
    );
  }
}