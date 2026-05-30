import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';
import 'package:usedev_uninassau/src/services/login_service.dart';
import 'package:usedev_uninassau/src/screens/initial_screen.dart';
import 'package:usedev_uninassau/src/screens/login_screen.dart';
import 'package:usedev_uninassau/src/widgets/cart_item_widget.dart';
import 'package:usedev_uninassau/src/widgets/cart_summary_widget.dart';
import 'package:usedev_uninassau/src/widgets/footer_widget.dart';
import 'package:usedev_uninassau/src/widgets/custom_app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    CartService.instance.addListener(_onCartChanged);
    _checkLoginStatus();
  }

  @override
  void dispose() {
    CartService.instance.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() => setState(() {});

  Future<void> _checkLoginStatus() async {
    final loggedIn = await LoginService.isLoggedIn();
    if (!mounted) return;
    setState(() => _isLoggedIn = loggedIn);
  }

  Future<void> _onCheckoutPressed() async {
    if (!_isLoggedIn) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Atenção',
            style: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Você precisa estar logado para finalizar a sua compra e garantir seus itens!',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancelar',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF780BF7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Fazer Login',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ],
        ),
      );
      return;
    }

    // Fluxo de sucesso
    CartService.instance.clear();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Compra finalizada com sucesso! Seu pedido está sendo processado.',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF780BF7),
      ),
    );

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const InitialScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = CartService.instance.items;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'O que você procura?',
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Icon(Icons.search, color: Colors.black, size: 20),
                  ],
                ),
              ),
            ),

            // Grid Banner
            Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Back Option
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back_ios, size: 14),
                    const SizedBox(width: 5),
                    Text(
                      'Carrinho de Compras',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (items.isEmpty)
              SizedBox(
                height: 300,
                child: Center(
                  child: Text(
                    'Seu carrinho está vazio',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      'Detalhes da compra',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(ci: items[index]);
                    },
                  ),
                  if (!_isLoggedIn)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF2F0),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFFF8A80)),
                        ),
                        child: Text(
                          'Dica: Faça login para aplicar cupons e finalizar sua compra com segurança.',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFFB00020),
                          ),
                        ),
                      ),
                    ),
                  CartSummaryWidget(onCheckout: _onCheckoutPressed),
                ],
              ),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
