import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';
import 'package:usedev_uninassau/src/screens/cart_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: CartService.instance,
      builder: (context, _) {
        final cartCount = CartService.instance.totalItems;
        final currentRoute = ModalRoute.of(context)?.settings.name;
        bool isCartScreen = currentRoute == '/cart';

        return AppBar(
          leading: const Icon(Icons.menu, size: 40.0),
          title: Image.asset('assets/Logo.png', height: 40),
          centerTitle: true,
          actions: [
            const Icon(Icons.person_outline, size: 40.0),
            const SizedBox(width: 10),
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: IconButton(
                    icon: Icon(Icons.shopping_cart_outlined, size: 32.0),
                    onPressed: () {
                      if (!isCartScreen) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CartScreen(),
                            settings: const RouteSettings(name: '/cart'),
                          ),
                        );
                      }
                    },
                  ),
                ),
                if (cartCount > 0)
                  Positioned(
                    right: 2,
                    top: 2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Center(
                        child: Text(
                          cartCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        );
      },
    );
  }
}
