import 'package:flutter/material.dart';

class QtyButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const QtyButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: Icon(icon, size: 16, color: Colors.grey),
      ),
    );
  }
}
