import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/helper/form_helper.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/model/analytic_models.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';

class AllAnalytics extends StatefulWidget {
  const AllAnalytics({Key? key}) : super(key: key);

  @override
  _AllAnalyticsState createState() => _AllAnalyticsState();
}

class _AllAnalyticsState extends State<AllAnalytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Analytics Summary',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: AppColors.bgColor,
        elevation: 0,
      ),
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        child: ListView.builder(
          itemCount: months.length,
          itemBuilder: (context, index) {
            return FutureBuilder<AnalyticsModel>(
              future: si.analyticsService.getMonthlyTotalAmount(months[index]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return AnalyticsSummaryCard(
                    title: '',
                    svg: analyticsSvgs[index],
                    amount: 0,
                    balance: 0,
                    expense: 0,
                    quantity: 0,
                  );
                }
                AnalyticsModel? monthlyAnalytics = snapshot.data;
                return AnalyticsSummaryCard(
                  title: '${months[index]} Overview',
                  amount: monthlyAnalytics == null
                      ? 0
                      : monthlyAnalytics.monthlyTotalAmountPaid,
                  quantity: monthlyAnalytics == null
                      ? 0
                      : monthlyAnalytics.monthlyTotalQuantity,
                  balance: monthlyAnalytics == null
                      ? 0
                      : monthlyAnalytics.monthlyTotalPendingBalance,
                  expense: monthlyAnalytics == null
                      ? 0
                      : monthlyAnalytics.monthlyTotalExpense,
                  svg: analyticsSvgs[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class AnalyticsSummaryCard extends StatelessWidget {
  final String title, svg;
  final int quantity, amount, balance, expense;
  const AnalyticsSummaryCard(
      {Key? key,
      required this.title,
      required this.svg,
      required this.amount,
      required this.balance,
      required this.expense,
      required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190,
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                formatNumber(quantity),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.done, color: Colors.green, size: 19.0),
                  const Text('Recieved: '),
                  Text(
                    formatMoney(amount),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.schedule,
                      color: Colors.amberAccent, size: 19.0),
                  const Text('Balance: '),
                  Text(
                    formatMoney(balance),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.paid_outlined,
                      color: Colors.red, size: 19.0),
                  const Text('Spent: '),
                  Text(
                    formatMoney(expense),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: SvgPicture.asset(svg),
          ),
        ],
      ),
    );
  }
}
