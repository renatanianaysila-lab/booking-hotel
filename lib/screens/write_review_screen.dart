import 'package:flutter/material.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({super.key});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  double _rating = 4;

  final TextEditingController _reviewController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
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
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF1510C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ulasan berhasil dikirim'),
                  backgroundColor: Color(0xFFF1510C),
                ),
              );

              Navigator.pop(context);
            },
            child: const Text(
              'Kirim',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'InclusiveSans',
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // IMAGE
            Stack(
              children: [
                SizedBox(
                  height: 240,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/Rectangle 11.png',
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 16,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEFE8),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Diskon 20%',
                            style: TextStyle(
                              color: Color(0xFFF1510C),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const Spacer(),

                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),

                        const SizedBox(width: 4),

                        const Text(
                          '4.8 (107 ulasan)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      'Hotel Majapahit',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'InclusiveSans',
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'Surabaya Pusat',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: 'InclusiveSans',
                      ),
                    ),

                    const SizedBox(height: 20),

                    Divider(color: Colors.grey.shade300),

                    const SizedBox(height: 18),

                    const Text(
                      'Penilaian keseluruhan produk ini',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // STAR RATING
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => IconButton(
                          onPressed: () {
                            setState(() {
                              _rating = index + 1;
                            });
                          },
                          icon: Icon(
                            Icons.star,
                            size: 38,
                            color: index < _rating
                                ? Colors.amber
                                : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Tulis ulasan lengkap',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'InclusiveSans',
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: _reviewController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Masukkan ulasan di sini...',
                        filled: true,
                        fillColor: const Color(0xFFFFF5F1),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: const [
                        Icon(
                          Icons.image_outlined,
                          color: Color(0xFFF1510C),
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'tambah foto',
                          style: TextStyle(
                            color: Color(0xFFF1510C),
                            fontWeight: FontWeight.w500,
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
}