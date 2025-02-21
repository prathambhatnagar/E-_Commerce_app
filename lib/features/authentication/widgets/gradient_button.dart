import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const GradientButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.pinkAccent, Colors.purpleAccent],
        ),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            elevation: 0),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, letterSpacing: 1.5),
        ),
      ),
    );
  }
}
