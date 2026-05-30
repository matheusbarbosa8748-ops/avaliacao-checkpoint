import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/product_model.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';
import 'package:usedev_uninassau/src/widgets/subscription_section_widgets.dart';
import 'package:usedev_uninassau/src/widgets/footer_widget.dart';
import 'package:usedev_uninassau/src/widgets/custom_app_bar.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.product})
    : super(key: key);

  final ProductModel product;

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  String? _selectedSize;
  String _selectedColor = 'Bege';
  final List<String> _sizes = ['P', 'M', 'G', 'GG'];
  final List<String> _colors = ['Bege', 'Branca', 'Cinza'];

  bool get _isClothing =>
      widget.product.category.toLowerCase().contains('clothing') ||
      widget.product.title.toLowerCase().contains('camiseta') ||
      widget.product.title.toLowerCase().contains('blusa');

  @override
  void initState() {
    super.initState();
    if (_isClothing) {
      _selectedSize = 'M';
    }
  }

  void _addToCart() {
    CartService.instance.addProduct(
      widget.product,
      quantity: _quantity,
      size: _selectedSize,
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Adicionado ao carrinho')));
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final poppinsBold = GoogleFonts.poppins(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'O que você procura?',
                        style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
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
                      'Detalhes do Produto',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(p.image, height: 300, fit: BoxFit.contain),
                  const SizedBox(height: 16),
                  Text(
                    p.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.orbitron().fontFamily,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.share_outlined, color: Color(0xFF780BF7)),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border, color: Color(0xFF780BF7)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Text(
                    p.description,
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    p.price.toStringAsFixed(2).replaceAll('.', ','),
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Color Selection
                  if (_isClothing) ...[
                    Text('Escolha a cor do tecido', style: poppinsBold),
                    const SizedBox(height: 8),
                    ..._colors.map((color) => InkWell(
                      onTap: () => setState(() => _selectedColor = color),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: color,
                            groupValue: _selectedColor,
                            onChanged: (value) {
                              setState(() {
                                _selectedColor = value!;
                              });
                            },
                            activeColor: const Color(0xFF780BF7),
                          ),
                          Text(color, style: GoogleFonts.poppins()),
                        ],
                      ),
                    )).toList(),
                    const SizedBox(height: 20),
                  ],
                  
                  // Quantity Selection
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _quantity,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                        onChanged: (int? newValue) {
                          setState(() {
                            _quantity = newValue!;
                          });
                        },
                        items: List.generate(10, (index) => index + 1)
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text('Quantidade: $value', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  
                  // Size Selection
                  if (_isClothing)
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedSize,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedSize = newValue;
                            });
                          },
                          items: _sizes.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text('Tamanho: $value', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  
                  ElevatedButton.icon(
                    onPressed: _addToCart,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF780BF7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                      size: 24,
                    ),
                    label: Text(
                      'Adicionar ao carrinho',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const SubscriptionSectionWidgets(),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
