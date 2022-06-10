import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:u_arewa_studio/shared/widgets/cards/primary_card.dart';

class AnalyticsCard extends StatelessWidget {
  final String title;
  final String quantity;
  final String amount;
  final String icon;
  final Color color;
  const AnalyticsCard(
      {Key? key,
      required this.title,
      required this.quantity,
      required this.amount,
      required this.color,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15.0),
          Center(
            child: SizedBox(
              height: 80,
              child: SvgPicture.asset(icon, width: 80),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          amount == ''
              ? const SizedBox(height: 15.0)
              : Row(
                  children: [
                    Text(title == 'Connections' ? 'Paid: ' : 'Amount: '),
                    SizedBox(
                      height: 18,
                      width: 70,
                      child: Text(
                        amount.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
          const SizedBox(height: 12.0),
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
