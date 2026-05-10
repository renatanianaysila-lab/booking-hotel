import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  final bool isFromSignUp; // Untuk membedakan dari sign up atau reset password

  const VerificationScreen({
    super.key,
    required this.email,
    this.isFromSignUp = true,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  
  bool _isLoading = false;
  bool _isResending = false;
  int _resendCooldown = 30;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendCooldown > 0) {
        setState(() {
          _resendCooldown--;
        });
        _startResendTimer();
      }
    });
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  void _onChanged(String value, int index) {
    // Hapus error message saat user mengetik
    if (_errorMessage != null) {
      setState(() {
        _errorMessage = null;
      });
    }

    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});

    // Auto verify when all fields filled
    if (_otpCode.length == 4 && value.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _handleVerify();
      });
    }
  }

  Future<void> _handleVerify() async {
    if (_otpCode.length < 4) {
      _showSnackbar('Masukkan 4 digit kode OTP');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (widget.isFromSignUp) {
        // Verifikasi untuk sign up
        final response = await Supabase.instance.client.auth.verifyOTP(
          email: widget.email,
          token: _otpCode,
          type: OtpType.signup,
        );

        if (response.user != null && mounted) {
          _showSnackbar('Verifikasi berhasil! Silakan login.', isError: false);
          
          // Navigate to login screen
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        }
      } else {
        // PERBAIKAN 1: Hapus parameter 'arguments' yang tidak didukung
        // Verifikasi untuk reset password - langsung navigasi ke ResetPasswordScreen
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ResetPasswordScreen(),
              // HAPUS: arguments - Flutter MaterialPageRoute tidak mendukung parameter 'arguments'
            ),
          );
        }
      }
    } on AuthException catch (e) {
      String errorMessage = _getErrorMessage(e.message);
      setState(() {
        _errorMessage = errorMessage;
      });
      _showSnackbar(errorMessage);
      
      // Clear OTP fields on error
      for (var controller in _controllers) {
        controller.clear();
      }
      if (mounted) {
        _focusNodes[0].requestFocus();
      }
    } catch (e) {
      // PERBAIKAN 2: Hapus braces yang tidak perlu dalam string interpolation
      String errorMessage = 'Verifikasi gagal: ${e.toString()}';
      setState(() {
        _errorMessage = errorMessage;
      });
      _showSnackbar(errorMessage);
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
    if (msg.contains('invalid otp') || msg.contains('token')) {
      return 'Kode OTP salah. Silakan cek kembali kode yang Anda masukkan.';
    } else if (msg.contains('expired')) {
      return 'Kode OTP sudah kadaluarsa. Silakan kirim ulang kode baru.';
    } else if (msg.contains('already verified')) {
      return 'Email sudah terverifikasi. Silakan login.';
    }
    return message;
  }

  Future<void> _handleResend() async {
    if (_resendCooldown > 0) {
      _showSnackbar('Tunggu $_resendCooldown detik sebelum mengirim ulang');
      return;
    }

    setState(() {
      _isResending = true;
      _errorMessage = null;
    });

    try {
      // Kirim ulang OTP
      await Supabase.instance.client.auth.resend(
        type: widget.isFromSignUp ? OtpType.signup : OtpType.recovery,
        email: widget.email,
      );

      setState(() {
        _resendCooldown = 30;
      });
      
      _startResendTimer();
      _showSnackbar(
        'Kode OTP telah dikirim ulang ke ${widget.email}',
        isError: false,
      );
      
      // Clear fields
      for (var controller in _controllers) {
        controller.clear();
      }
      if (mounted) {
        _focusNodes[0].requestFocus();
      }
    } on AuthException catch (e) {
      _showSnackbar(e.message);
    } catch (e) {
      _showSnackbar('Gagal mengirim ulang kode: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    }
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(height: 40),

              // Title
              const Center(
                child: Text(
                  'Verifikasi Email',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'InclusiveSans',
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Subtitle
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: 'InclusiveSans',
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: widget.isFromSignUp 
                            ? 'Masukkan kode verifikasi yang kami kirim\nke email '
                            : 'Masukkan kode OTP yang kami kirim\nke email ',
                      ),
                      TextSpan(
                        text: widget.email,
                        style: const TextStyle(
                          color: Color(0xFFF1510C),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'InclusiveSans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Info tambahan
              if (widget.isFromSignUp)
                Center(
                  child: Text(
                    'Cek juga folder spam jika tidak menemukan email',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      fontFamily: 'InclusiveSans',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              const SizedBox(height: 32),

              // Error Message
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.red.shade700,
                            fontFamily: 'InclusiveSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        enabled: !_isLoading,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'InclusiveSans',
                        ),
                        decoration: InputDecoration(
                          counterText: '',
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
                            borderSide: const BorderSide(
                              color: Color(0xFFF1510C),
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.red.shade300, width: 1),
                          ),
                        ),
                        onChanged: (value) => _onChanged(value, index),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),

              // Kirim Ulang
              Center(
                child: Column(
                  children: [
                    Text(
                      'Tidak menerima kode OTP?',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontFamily: 'InclusiveSans',
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: (_isResending || _resendCooldown > 0) ? null : _handleResend,
                      child: Text(
                        _isResending
                            ? 'Mengirim...'
                            : _resendCooldown > 0
                                ? 'Kirim Ulang ($_resendCooldown s)'
                                : 'Kirim Ulang',
                        style: TextStyle(
                          fontSize: 14,
                          color: (_isResending || _resendCooldown > 0) 
                              ? Colors.grey 
                              : const Color(0xFFF1510C),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'InclusiveSans',
                          decoration: (_isResending || _resendCooldown > 0) 
                              ? null 
                              : TextDecoration.underline,
                          decorationColor: const Color(0xFFF1510C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Verifikasi Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: (_isLoading || _isResending) ? null : _handleVerify,
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
                          'Verifikasi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'InclusiveSans',
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ResetPasswordScreen untuk lupa password
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

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

    setState(() {
      _isLoading = true;
    });

    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: password),
      );

      _showSnackbar('Password berhasil diubah! Silakan login.', isError: false);
      
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
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
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontFamily: 'InclusiveSans')),
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
          'Reset Password',
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
              'Buat Password Baru',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'InclusiveSans',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Buat password baru yang kuat dan mudah diingat',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontFamily: 'InclusiveSans',
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Password Baru',
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
                hintText: 'Minimal 6 karakter',
                filled: true,
                fillColor: const Color(0xFFFFF3EE),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Konfirmasi Password',
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
              onSubmitted: (_) => _handleResetPassword(),
              decoration: InputDecoration(
                hintText: 'Ketik ulang password baru',
                filled: true,
                fillColor: const Color(0xFFFFF3EE),
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleResetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF1510C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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