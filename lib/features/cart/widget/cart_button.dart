import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  final Color? color;

  const CartButton(
      {super.key, required this.label, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onTap,
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: color)),
    );
  }
}
