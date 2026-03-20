import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/auth/controller/auth_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late final AuthController _authController;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // ── Design tokens (same as LoginPage) ──
  static const Color _primaryColor = Color(0xFF3F51B5);
  static const Color _darkText = Color(0xFF1A1A2E);
  static const Color _subtitleText = Color(0xFF6B7280);
  static const Color _labelText = Color(0xFF4B5563);
  static const Color _borderColor = Color(0xFFD1D5DB);
  static const Color _hintColor = Color(0xFF9CA3AF);

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onSignupPressed() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    await _authController.signup(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  InputDecoration _underlineInput({
    required String hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: _hintColor, fontSize: 15),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: _borderColor, width: 1.2),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: _primaryColor, width: 2),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 1.2),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 2),
      ),
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // ── Logo / Brand ──
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      Icon(Icons.grid_view_rounded,
                          color: _primaryColor, size: 28),
                      const SizedBox(width: 10),
                      const Text(
                        'QuizApp',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: _primaryColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),

                  // ── Heading ──
                  const SizedBox(height: 40),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: _darkText,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Join QuizApp and start testing your\nknowledge today.',
                    style: TextStyle(
                      fontSize: 15,
                      color: _subtitleText,
                      height: 1.5,
                    ),
                  ),

                  // ── Email field ──
                  const SizedBox(height: 40),
                  const Text(
                    'EMAIL ADDRESS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _labelText,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const <String>[AutofillHints.email],
                    style: const TextStyle(fontSize: 15, color: _darkText),
                    decoration:
                        _underlineInput(hintText: 'name@organization.com'),
                    validator: (String? value) {
                      final String input = value?.trim() ?? '';
                      if (input.isEmpty) {
                        return 'Email is required';
                      }
                      if (!GetUtils.isEmail(input)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),

                  // ── Password field ──
                  const SizedBox(height: 28),
                  const Text(
                    'PASSWORD',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _labelText,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    autofillHints: const <String>[AutofillHints.newPassword],
                    style: const TextStyle(fontSize: 15, color: _darkText),
                    decoration: _underlineInput(
                      hintText: '••••••••',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: _hintColor,
                          size: 20,
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      final String input = value ?? '';
                      if (input.isEmpty) {
                        return 'Password is required';
                      }
                      if (input.length < 6) {
                        return 'Use at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  // ── Confirm Password field ──
                  const SizedBox(height: 28),
                  const Text(
                    'CONFIRM PASSWORD',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _labelText,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    autofillHints: const <String>[AutofillHints.newPassword],
                    style: const TextStyle(fontSize: 15, color: _darkText),
                    decoration: _underlineInput(
                      hintText: '••••••••',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword =
                                !_obscureConfirmPassword;
                          });
                        },
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: _hintColor,
                          size: 20,
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      if ((value ?? '').isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  // ── Create Account button ──
                  const SizedBox(height: 36),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _authController.isSignupLoading.value
                            ? null
                            : _onSignupPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          disabledBackgroundColor:
                              _primaryColor.withValues(alpha: 0.6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: _authController.isSignupLoading.value
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Text(
                                'CREATE ACCOUNT',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                ),
                              ),
                      ),
                    ),
                  ),

                  // ── Bottom navigation ──
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Already have an account?  ',
                        style: TextStyle(
                          fontSize: 14,
                          color: _subtitleText,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back<void>(),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ── Footer ──
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.lock_outline, size: 14, color: _hintColor),
                      const SizedBox(width: 6),
                      Text(
                        'END-TO-END ENCRYPTED SESSION',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: _hintColor,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
