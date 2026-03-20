import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/auth/controller/auth_controller.dart';
import 'package:quiz_app/routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final AuthController _authController;
  bool _obscurePassword = true;

  // ── Design tokens ──
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
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    await _authController.login(
      email: _emailController.text,
      password: _passwordController.text,
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
                    'Sign in',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: _darkText,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Welcome back. Please enter your credentials to\naccess your dashboard.',
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
                    decoration: InputDecoration(
                      hintText: 'name@organization.com',
                      hintStyle:
                          const TextStyle(color: _hintColor, fontSize: 15),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 0),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: _borderColor, width: 1.2),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: _primaryColor, width: 2),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 1.2),
                      ),
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 2),
                      ),
                    ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'PASSWORD',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _labelText,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        'FORGOT?',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _primaryColor,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    autofillHints: const <String>[AutofillHints.password],
                    style: const TextStyle(fontSize: 15, color: _darkText),
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      hintStyle:
                          const TextStyle(color: _hintColor, fontSize: 15),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 0),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: _borderColor, width: 1.2),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: _primaryColor, width: 2),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 1.2),
                      ),
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 2),
                      ),
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
                      if ((value ?? '').isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),

                  // ── Authenticate button ──
                  const SizedBox(height: 36),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _authController.isLoginLoading.value
                            ? null
                            : _onLoginPressed,
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
                        child: _authController.isLoginLoading.value
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
                                'AUTHENTICATE',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                ),
                              ),
                      ),
                    ),
                  ),

                  // ── Divider ──
                  const SizedBox(height: 32),
                  Row(
                    children: <Widget>[
                      const Expanded(
                          child: Divider(color: _borderColor, thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR CONTINUE WITH',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _hintColor,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      const Expanded(
                          child: Divider(color: _borderColor, thickness: 1)),
                    ],
                  ),

                  // ── Bottom navigation ──
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Don't have an account?  ",
                        style: TextStyle(
                          fontSize: 14,
                          color: _subtitleText,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.signup),
                        child: const Text(
                          'Create an account',
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
                      Icon(Icons.lock_outline,
                          size: 14, color: _hintColor),
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
