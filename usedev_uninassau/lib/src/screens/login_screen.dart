import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/screens/initial_screen.dart';
import 'package:usedev_uninassau/src/services/login_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _alreadyLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final poppinsBold = GoogleFonts.poppins(fontWeight: FontWeight.bold);
    final poppinsRegular = GoogleFonts.poppins();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              _buildLogoSection(poppinsBold, poppinsRegular),
              const SizedBox(height: 30),
              if (_alreadyLoggedIn) _buildAlreadyLoggedInCard(poppinsBold),
              if (_alreadyLoggedIn) const SizedBox(height: 12),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildInputField(
                      label: 'Usuário',
                      hintText: 'Digite seu usuário',
                      controller: _userController,
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      label: 'Senha',
                      hintText: 'Digite sua senha',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _onLoginPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF780BF7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          textStyle: poppinsBold.copyWith(fontSize: 16),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                  strokeWidth: 2.4,
                                ),
                              )
                            : Text(
                                'Entrar',
                                style: poppinsBold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(TextStyle titleStyle, TextStyle subtitleStyle) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: double.infinity,
          child: Image.asset('assets/Logo.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 15),
        Text(
          'Faça login com seu usuário para continuar',
          textAlign: TextAlign.center,
          style: subtitleStyle.copyWith(fontSize: 15, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText ? _obscurePassword : false,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Este campo é obrigatório';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            suffixIcon: obscureText
                ? IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: const Color(0xFF780BF7),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Color(0xFF780BF7)),
            ),
          ),
          style: GoogleFonts.poppins(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildAlreadyLoggedInCard(TextStyle buttonStyle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF7FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF780BF7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Você já está logado.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Toque abaixo para ir direto para a tela principal.',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _navigateToMainScreen,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF780BF7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                textStyle: buttonStyle.copyWith(fontSize: 14),
              ),
              child: Text(
                'Ir para a tela principal',
                style: buttonStyle.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onLoginPressed() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final token = await LoginService.login(
        username: _userController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login realizado com sucesso',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF780BF7),
          ),
        );

        _navigateToMainScreen();
      }

      debugPrint('Token armazenado: $token');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erro ao fazer login: ${e.toString()}',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _checkLoginStatus() async {
    final loggedIn = await LoginService.isLoggedIn();
    if (mounted) {
      setState(() {
        _alreadyLoggedIn = loggedIn;
      });
    }
  }

  void _navigateToMainScreen() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const InitialScreen()),
      (route) => false,
    );
  }
}
