import 'package:flutter/material.dart';

class RoundOutlinedIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final void Function()? onPressed;
  const RoundOutlinedIconButton({
    required this.icon,
    required this.color,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(color: Colors.grey),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
