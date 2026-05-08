import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
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
              // Logo
              Center(
                child: Image.asset(
                  'assets/Logo.png',
                  height: 80,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.login, size: 80, color: Color(0xFFF1510C));
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Title
              const Center(
                child: Text(
                  'Masuk',
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
                  'Halo! Selamat datang kembali',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontFamily: 'InclusiveSans',
                  ),
                ),
              ),
              const SizedBox(height: 48),

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

              // Password Field
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
              const SizedBox(height: 12),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    _showSnackbar('Fitur lupa kata sandi akan segera hadir');
                  },
                  child: const Text(
                    'Lupa Kata Sandi ?',
                    style: TextStyle(
                      color: Color(0xFFF1510C),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'InclusiveSans',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1510C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Masuk',
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

              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun ?',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'InclusiveSans',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Daftar',
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
        _handleSocialLogin(label);
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

  void _handleLogin() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty) {
      _showSnackbar('Email tidak boleh kosong');
      return;
    }

    if (password.isEmpty) {
      _showSnackbar('Kata sandi tidak boleh kosong');
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      _showSnackbar('Email tidak valid');
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _handleSocialLogin(String provider) {
    _showSnackbar('Login dengan $provider akan segera hadir');
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