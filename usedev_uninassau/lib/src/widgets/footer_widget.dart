import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    final itemStyle = GoogleFonts.poppins(
      color: Colors.white70,
      fontSize: 14,
    );

    return Container(
      color: const Color(0xFF0D0821),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset('assets/Logo.png', height: 50),
                const SizedBox(height: 8),
                Text(
                  'Hora de abraçar seu lado geek!',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF8FFF24),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFF8FFF24), thickness: 1),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Funcionamento', style: titleStyle),
          const SizedBox(height: 8),
          Text('Segunda a Sexta - 8h às 18h', style: itemStyle),
          Text('sac@usedev.com.br', style: itemStyle),
          Text('0800 541 320', style: itemStyle),
          const SizedBox(height: 24),
          Text('Institucional', style: titleStyle),
          const SizedBox(height: 8),
          Text('Sobre nós', style: itemStyle),
          Text('Contato', style: itemStyle),
          Text('Política de Privacidade', style: itemStyle),
          Text('LGPD - Lei de proteção de dados', style: itemStyle),
          const SizedBox(height: 24),
          Text('Informações', style: titleStyle),
          const SizedBox(height: 8),
          Text('Entregas', style: itemStyle),
          Text('Garantia', style: itemStyle),
          Text('Trocas e devoluções', style: itemStyle),
          const SizedBox(height: 24),
          Text('Formas de Pagamento', style: titleStyle),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildPaymentIcon(Icons.credit_card), // Placeholder for Visa
              _buildPaymentIcon(Icons.payment),     // Placeholder for Mastercard
              _buildPaymentIcon(Icons.account_balance_wallet), // Placeholder for Elo
              _buildPaymentIcon(Icons.pix),         // Pix icon
            ],
          ),
          const SizedBox(height: 24),
          Text('Siga nossas redes:', style: titleStyle),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildSocialIcon(Icons.camera_alt_outlined),
              const SizedBox(width: 16),
              _buildSocialIcon(Icons.camera_alt_outlined), // Instagram
              const SizedBox(width: 16),
              _buildSocialIcon(Icons.music_note), // TikTok
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPaymentIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, size: 30, color: Colors.black),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF780BF7), width: 1.5),
      ),
      child: Icon(icon, color: const Color(0xFF780BF7), size: 24),
    );
  }
}
