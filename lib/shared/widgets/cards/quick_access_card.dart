import 'package:flutter/material.dart';

class QuickAccessCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  const QuickAccessCard({Key? key, required this.color, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 26.0, color: Colors.white),
    );
  }
}
