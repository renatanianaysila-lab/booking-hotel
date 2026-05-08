import 'package:flutter/material.dart';
import 'login_screen.dart';
// TODO: import 'verification_screen.dart'; // Uncomment saat sudah dibuat

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Center(
                child: Text(
                  'Buat Akun',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'InclusiveSans',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Isi data di bawah, atau daftar\ndengan akun media sosial',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontFamily: 'InclusiveSans',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 36),

              // Nama Field
              const Text(
                'Nama',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'InclusiveSans',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Nama',
                  hintStyle: TextStyle(
                    fontFamily: 'InclusiveSans',
                    color: Colors.grey[400],
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFFF3EE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFF1510C), width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                style: const TextStyle(fontFamily: 'InclusiveSans'),
              ),
              const SizedBox(height: 20),

              // Email Field
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'InclusiveSans',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'nama@example.com',
                  hintStyle: TextStyle(
                    fontFamily: 'InclusiveSans',
                    color: Colors.grey[400],
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFFF3EE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFF1510C), width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                style: const TextStyle(fontFamily: 'InclusiveSans'),
              ),
              const SizedBox(height: 20),

              // Kata Sandi Field
              const Text(
                'Kata Sandi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'InclusiveSans',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: '********',
                  hintStyle: TextStyle(
                    fontFamily: 'InclusiveSans',
                    color: Colors.grey[400],
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFFF3EE),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFF1510C), width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                style: const TextStyle(fontFamily: 'InclusiveSans'),
              ),
              const SizedBox(height: 16),

              // Checkbox Syarat & Ketentuan
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                    activeColor: const Color(0xFFF1510C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          fontFamily: 'InclusiveSans',
                        ),
                        children: [
                          const TextSpan(text: 'Setuju dengan '),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                _showSnackbar('Syarat & Ketentuan akan segera hadir');
                              },
                              child: const Text(
                                'Syarat & Ketentuan',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFFF1510C),
                                  fontFamily: 'InclusiveSans',
                                  fontWeight: FontWeight.w500,
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
              const SizedBox(height: 24),

              // Daftar Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1510C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'InclusiveSans',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // OR Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Atau masuk dengan',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: 'InclusiveSans',
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),
              const SizedBox(height: 24),

              // Social Login Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton('assets/google.png', 'Google'),
                  const SizedBox(width: 20),
                  _buildSocialButton('assets/facebook.png', 'Facebook'),
                  const SizedBox(width: 20),
                  _buildSocialButton('assets/apple.png', 'Apple'),
                ],
              ),
              const SizedBox(height: 32),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun ?',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'InclusiveSans',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        color: Color(0xFFF1510C),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'InclusiveSans',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String assetPath, String label) {
    return InkWell(
      onTap: () {
        _showSnackbar('Daftar dengan $label akan segera hadir');
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Image.asset(
          assetPath,
          height: 28,
          width: 28,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: Center(
                child: Text(
                  label[0],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleRegister() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty) {
      _showSnackbar('Nama tidak boleh kosong');
      return;
    }

    if (email.isEmpty) {
      _showSnackbar('Email tidak boleh kosong');
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      _showSnackbar('Email tidak valid');
      return;
    }

    if (password.isEmpty) {
      _showSnackbar('Kata sandi tidak boleh kosong');
      return;
    }

    if (password.length < 6) {
      _showSnackbar('Kata sandi minimal 6 karakter');
      return;
    }

    if (!_agreeToTerms) {
      _showSnackbar('Harap setujui Syarat & Ketentuan terlebih dahulu');
      return;
    }

    // TODO: Navigasi ke VerificationScreen saat sudah dibuat
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const VerificationScreen()),
    // );
    _showSnackbar('Kode verifikasi telah dikirim ke $email');
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'InclusiveSans'),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}