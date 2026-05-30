import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/cart_item_model.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart'
    hide CartItemModel;
import 'package:usedev_uninassau/src/widgets/qty_button_widget.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel ci;

  const CartItemWidget({super.key, required this.ci});

  @override
  Widget build(BuildContext context) {
    final poppinsBold = GoogleFonts.poppins(fontWeight: FontWeight.bold);
    final isClothing =
        ci.product.category.toLowerCase().contains('clothing') ||
        ci.product.title.toLowerCase().contains('camiseta') ||
        ci.product.title.toLowerCase().contains('blusa');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                ci.product.image,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ci.product.title,
                      style: GoogleFonts.orbitron(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ci.product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'R\$ ${ci.product.price.toStringAsFixed(0)}',
                      style: poppinsBold.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Quantidade
              Column(
                children: [
                  Text(
                    'Quantidade:',
                    style: poppinsBold.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      QtyButtonWidget(
                        icon: Icons.remove,
                        onTap: () {
                          CartService.instance.updateQuantity(
                            ci.key,
                            ci.quantity - 1,
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 35,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('${ci.quantity}', style: poppinsBold),
                      ),
                      const SizedBox(width: 8),
                      QtyButtonWidget(
                        icon: Icons.add,
                        onTap: () {
                          CartService.instance.updateQuantity(
                            ci.key,
                            ci.quantity + 1,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              // Tamanho
              if (isClothing)
                Column(
                  children: [
                    Text('Tamanho:', style: poppinsBold.copyWith(fontSize: 14)),
                    const SizedBox(height: 8),
                    Container(
                      height: 35,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                      ),
                      child: DropdownButton<String>(
                        value: ci.size ?? 'M',
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            CartService.instance.updateSize(ci.key, newValue);
                          }
                        },
                        items: ['P', 'M', 'G', 'GG']
                            .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: poppinsBold.copyWith(fontSize: 12),
                                ),
                              );
                            })
                            .toList(),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => CartService.instance.removeProduct(ci.key),
            child: Column(
              children: [
                Text('Excluir', style: poppinsBold.copyWith(fontSize: 12)),
                const Icon(Icons.delete_outline, size: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
