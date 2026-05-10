import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'verification_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty) {
      _showSnackbar('Nama lengkap tidak boleh kosong');
      return;
    }

    if (email.isEmpty) {
      _showSnackbar('Email tidak boleh kosong');
      return;
    }

    if (!_isValidEmail(email)) {
      _showSnackbar('Format email tidak valid');
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

    if (password != confirmPassword) {
      _showSnackbar('Konfirmasi kata sandi tidak cocok');
      return;
    }

    if (!_agreeToTerms) {
      _showSnackbar('Anda harus menyetujui syarat dan ketentuan');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': name,
          'created_at': DateTime.now().toIso8601String(),
        },
      );

      if (response.user != null && mounted) {
        await Supabase.instance.client.auth.resend(
          type: OtpType.signup,
          email: email,
        );
        
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(
                email: email,
              ),
            ),
          );
        }
      }
    } on AuthException catch (e) {
      String errorMessage = _getErrorMessage(e.message);
      if (mounted) {
        _showSnackbar(errorMessage);
      }
    } catch (e) {
      if (mounted) {
        _showSnackbar('Terjadi kesalahan: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  String _getErrorMessage(String message) {
    final msg = message.toLowerCase();
    if (msg.contains('user already registered')) {
      return 'Email sudah terdaftar. Silakan login atau gunakan email lain.';
    } else if (msg.contains('password should be at least 6 characters')) {
      return 'Kata sandi minimal 6 karakter';
    } else if (msg.contains('invalid email')) {
      return 'Format email tidak valid';
    } else if (msg.contains('network')) {
      return 'Gagal terhubung ke server. Periksa koneksi internet Anda.';
    }
    return message;
  }

  void _showSnackbar(String message, {bool isError = true}) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'InclusiveSans'),
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF1510C)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Daftar Akun',
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
                  'Buat akun baru untuk memulai',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontFamily: 'InclusiveSans',
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              const Text(
                'Nama Lengkap',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'InclusiveSans',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: _buildInputDecoration(
                  hintText: 'Masukkan nama lengkap Anda',
                  prefixIcon: Icons.person_outline,
                ),
                style: const TextStyle(fontFamily: 'InclusiveSans'),
              ),
              const SizedBox(height: 20),
              
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
                decoration: _buildInputDecoration(
                  hintText: 'nama@example.com',
                  prefixIcon: Icons.email_outlined,
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
                textInputAction: TextInputAction.next,
                decoration: _buildInputDecoration(
                  hintText: 'Minimal 6 karakter',
                  prefixIcon: Icons.lock_outline,
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
                ),
                style: const TextStyle(fontFamily: 'InclusiveSans'),
              ),
              const SizedBox(height: 20),
              
              const Text(
                'Konfirmasi Kata Sandi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'InclusiveSans',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _handleSignUp(),
                decoration: _buildInputDecoration(
                  hintText: 'Ketik ulang kata sandi Anda',
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                style: const TextStyle(fontFamily: 'InclusiveSans'),
              ),
              const SizedBox(height: 16),
              
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
                    checkColor: Colors.white,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _agreeToTerms = !_agreeToTerms;
                        });
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontFamily: 'InclusiveSans',
                          ),
                          children: [
                            const TextSpan(text: 'Dengan mendaftar, Anda menyetujui '),
                            TextSpan(
                              text: 'Syarat & Ketentuan',
                              style: const TextStyle(
                                color: Color(0xFFF1510C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: ' dan '),
                            TextSpan(
                              text: 'Kebijakan Privasi',
                              style: const TextStyle(
                                color: Color(0xFFF1510C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: ' kami.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignUp,
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
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun?',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'InclusiveSans',
                    ),
                  ),
                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
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

  InputDecoration _buildInputDecoration({
    required String hintText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        fontFamily: 'InclusiveSans',
        color: Colors.grey[400],
      ),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.grey[400], size: 20)
          : null,
      suffixIcon: suffixIcon,
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
    );
  }
}