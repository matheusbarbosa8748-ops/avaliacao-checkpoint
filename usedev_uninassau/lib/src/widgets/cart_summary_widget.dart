import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';

class CartSummaryWidget extends StatelessWidget {
  final VoidCallback onCheckout;

  const CartSummaryWidget({super.key, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;
    final poppinsBold = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sumário', style: poppinsBold),
          const SizedBox(height: 16),
          Text('Cupom de desconto', style: poppinsBold.copyWith(fontSize: 14)),
          const SizedBox(height: 8),
          _buildInputWithButton('Digite o cupom'),
          const SizedBox(height: 16),
          Text('Frete', style: poppinsBold.copyWith(fontSize: 14)),
          const SizedBox(height: 8),
          _buildInputWithButton('Digite o CEP'),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF780BF7), thickness: 0.5),
          const SizedBox(height: 8),
          _buildSummaryRow(
            '${cart.totalItems.toString().padLeft(2, '0')} Produtos',
            'R\$ ${cart.totalPrice.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 8),
          _buildSummaryRow('Frete', 'R\$ 8'),
          const SizedBox(height: 8),
          const Divider(color: Color(0xFF780BF7), thickness: 0.5),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    color: Color(0xFF780BF7),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Total:',
                    style: poppinsBold.copyWith(color: const Color(0xFF780BF7)),
                  ),
                ],
              ),
              Text(
                'R\$ ${(cart.totalPrice + 8).toStringAsFixed(0)}',
                style: poppinsBold.copyWith(color: const Color(0xFF780BF7)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF780BF7)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Continuar comprando',
                style: poppinsBold.copyWith(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF780BF7),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Ir para pagamento',
                style: poppinsBold.copyWith(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputWithButton(String hint) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.black),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: GoogleFonts.poppins(fontSize: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF780BF7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            minimumSize: const Size(60, 45),
          ),
          child: Text(
            'Ok',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    final style = GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
