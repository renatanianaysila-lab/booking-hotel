import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'signup_screen.dart';
import 'home_screen.dart';
import 'forgot_password_screen.dart';

// Tambahkan import untuk logging
import 'dart:developer' as developer;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkAlreadyLoggedIn();
  }

  Future<void> _checkAlreadyLoggedIn() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null && mounted) {
        // Cek apakah email sudah diverifikasi
        if (user.emailConfirmedAt != null) {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        }
      }
    } catch (e) {
      // Ganti print dengan logging
      developer.log('Error checking login status', error: e);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty) {
      _showSnackbar('Email tidak boleh kosong');
      return;
    }

    if (password.isEmpty) {
      _showSnackbar('Kata sandi tidak boleh kosong');
      return;
    }

    // Validasi format email sederhana
    if (!email.contains('@') || !email.contains('.')) {
      _showSnackbar('Format email tidak valid');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null && mounted) {
        // Cek apakah email sudah diverifikasi
        final user = response.user;
        if (user?.emailConfirmedAt == null) {
          // Email belum diverifikasi
          _showSnackbar(
            'Email belum diverifikasi. Silakan cek email Anda untuk verifikasi.',
            isError: true,
            duration: 5, // Lebih lama untuk pesan penting
          );
          
          // Kirim ulang email verifikasi
          await Supabase.instance.client.auth.resend(
            type: OtpType.signup,
            email: email,
          );
          
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
          return;
        }
        
        _showSnackbar('Login berhasil!', isError: false, duration: 2);
        
        // Hapus semua route dan pergi ke HomeScreen
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );
        }
      }
    } on AuthException catch (e) {
      String errorMessage = _getErrorMessage(e.message);
      _showSnackbar(errorMessage, duration: 4);
      // Log error untuk debugging
      developer.log('Auth Exception: ${e.message}', name: 'LoginScreen');
    } catch (e) {
      _showSnackbar('Terjadi kesalahan: ${e.toString()}', duration: 4);
      developer.log('Login error', error: e, name: 'LoginScreen');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _getErrorMessage(String message) {
    final msg = message.toLowerCase();
    if (msg.contains('invalid login credentials')) {
      return 'Email atau kata sandi salah. Periksa kembali data Anda.';
    } else if (msg.contains('email not confirmed')) {
      return 'Email belum diverifikasi. Cek email Anda untuk verifikasi.';
    } else if (msg.contains('user not found')) {
      return 'Email tidak terdaftar. Silakan daftar terlebih dahulu.';
    } else if (msg.contains('password should be at least 6 characters')) {
      return 'Kata sandi minimal 6 karakter';
    } else if (msg.contains('network')) {
      return 'Gagal terhubung ke server. Periksa koneksi internet Anda.';
    }
    return message;
  }

  Future<void> _forgotPassword() async {
    // Navigate to forgot password screen instead of handling here
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  void _showSnackbar(String message, {bool isError = true, int duration = 3}) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'InclusiveSans'),
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
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
                textInputAction: TextInputAction.next,
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
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _handleLogin(),
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
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _isLoading ? null : _forgotPassword,
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
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1510C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    disabledBackgroundColor: Colors.grey[400],
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun?',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'InclusiveSans',
                    ),
                  ),
                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
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
      onTap: _isLoading
          ? null
          : () {
              _showSnackbar('Login dengan $label akan segera hadir', duration: 2);
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
}