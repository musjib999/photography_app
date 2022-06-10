import 'package:flutter/material.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';

class PrimaryOutlinedButton extends StatelessWidget {
  final String title;
  const PrimaryOutlinedButton({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Text(title),
      ),
    );
  }
}
