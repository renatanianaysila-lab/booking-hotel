import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showSnackbar('Email tidak boleh kosong');
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      _showSnackbar('Format email tidak valid');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(email);

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text(
              'Cek Email Anda',
              style: TextStyle(fontFamily: 'InclusiveSans'),
            ),
            content: Text(
              'Kami telah mengirimkan link reset password ke:\n\n$email\n\nSilakan cek inbox atau folder spam Anda.',
              style: const TextStyle(fontFamily: 'InclusiveSans'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text(
                  'Kembali ke Login',
                  style: TextStyle(color: Color(0xFFF1510C)),
                ),
              ),
            ],
          ),
        );
      }
    } on AuthException catch (e) {
      _showSnackbar(e.message);
    } catch (e) {
      _showSnackbar('Terjadi kesalahan: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackbar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'InclusiveSans'),
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
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
        title: const Text(
          'Lupa Password',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'InclusiveSans',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Icon(
                Icons.lock_reset,
                size: 80,
                color: Color(0xFFF1510C),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'InclusiveSans',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Masukkan email Anda untuk menerima link reset password',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontFamily: 'InclusiveSans',
              ),
            ),
            const SizedBox(height: 32),
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
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _sendResetPassword(),
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
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _sendResetPassword,
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
                        'Kirim Link Reset',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'InclusiveSans',
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}