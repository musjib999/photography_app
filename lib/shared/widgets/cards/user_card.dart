import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';

class UserCard extends StatelessWidget {
  final String displayName, email, phone, status, role, title;

  const UserCard({
    Key? key,
    required this.title,
    required this.displayName,
    required this.status,
    required this.email,
    required this.phone,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'RedHatMono',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Ionicons.person_outline),
                  ),
                  const SizedBox(width: 15.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(role),
                    ],
                  ),
                ],
              ),
              Text(
                status,
                style: TextStyle(
                  color: status == 'Active' || status == 'Working'
                      ? Colors.green
                      : Colors.amberAccent,
                ),
              )
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const Icon(Icons.email_outlined, color: AppColors.primaryColor),
              const SizedBox(width: 3.0),
              Text(
                email,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Row(
            children: [
              const Icon(Icons.phone_outlined, color: AppColors.primaryColor),
              const SizedBox(width: 3.0),
              Text(
                phone,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
