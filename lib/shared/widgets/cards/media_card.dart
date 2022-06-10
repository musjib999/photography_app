import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/helper/form_helper.dart';
import 'package:u_arewa_studio/helper/url_helper.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';

class MediaCard extends StatelessWidget {
  final DateTime timestamp;
  final String pictureType;
  final String status;
  final int price;
  final int amountpaid;
  final int pendingBalance;
  final String link;
  const MediaCard({
    Key? key,
    required this.timestamp,
    required this.pictureType,
    required this.status,
    required this.price,
    required this.amountpaid,
    required this.pendingBalance,
    required this.link,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Ionicons.image_outline),
                  ),
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pictureType,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'RedHatMono',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text('${timestamp.hour}:${timestamp.minute}'),
                    ],
                  ),
                ],
              ),
              Text(
                status,
                style: TextStyle(
                  color: status == 'Done' ? Colors.green : Colors.amberAccent,
                ),
              )
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const Icon(
                Ionicons.cash_outline,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 3.0),
              const Text(
                'Price:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                formatMoney(price),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              const Icon(
                Ionicons.cash_outline,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 3.0),
              const Text(
                'Amount paid:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                formatNumber(amountpaid),
                style: const TextStyle(fontSize: 16, color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              const Icon(
                Ionicons.cash_outline,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 3.0),
              const Text(
                'Outstanding Balance:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                formatMoney(pendingBalance),
                style: const TextStyle(fontSize: 16, color: Colors.amberAccent),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Icon(
            Icons.link,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 3.0),
          GestureDetector(
            onTap: () => link == '' ? () {} : renderUrl(link),
            child: Text(
              link == '' ? 'link not available' : link,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
