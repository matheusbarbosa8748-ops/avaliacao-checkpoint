import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/widgets/hero_tela.dart';
import 'package:usedev_uninassau/src/widgets/product_card_widgets.dart';
import 'package:usedev_uninassau/src/widgets/subscription_section_widgets.dart';
import 'package:usedev_uninassau/src/widgets/footer_widget.dart';
import 'package:usedev_uninassau/src/widgets/custom_app_bar.dart';
import 'package:usedev_uninassau/src/services/product_service.dart';
import 'package:usedev_uninassau/src/models/product_model.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeroTela(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Promos Especiais',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                ),
              ),
            ),
            FutureBuilder<List<ProductModel>>(
              future: ProductService.getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Erro ao carregar produtos: ${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('Nenhum produto disponível'),
                    ),
                  );
                }

                final products = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) =>
                      ProductCardWidgets(product: products[index]),
                );
              },
            ),
            const SubscriptionSectionWidgets(),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
