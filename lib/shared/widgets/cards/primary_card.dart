import 'package:flutter/material.dart';

class PrimaryCard extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Widget child;
  const PrimaryCard({Key? key, required this.child, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
