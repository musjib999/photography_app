import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/helper/date_helper.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/expense/add_expense.dart';

import '../../../../../../shared/themes/colors.dart';
import '../../../../../helper/form_helper.dart';
import '../../../../../shared/global/globals.dart';
import '../../../../../shared/model/expense_model.dart';

class AllExpense extends StatefulWidget {
  const AllExpense({Key? key}) : super(key: key);

  @override
  _AllExpenseState createState() => _AllExpenseState();
}

class _AllExpenseState extends State<AllExpense> {
  List<Widget> expenseWidgets = [];
  String selectedMonth = getTodaysDate().split(',')[0].split(' ')[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'All Expense',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: DropdownButton<dynamic>(
              items: getDropdownItems(months),
              onChanged: (value) {
                setState(() {
                  selectedMonth = value;
                });
              },
              icon: const Icon(Ionicons.calendar_outline),
              underline: Container(),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<ExpenseModel>>(
        future: si.expenseService.getAllExpense(
            '$baseUrl/getAllExpensesByMonth?month=$selectedMonth'),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Pls Check Your Internet Connection',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19, fontFamily: 'RedHatMono'),
              ),
            );
          }
          return snapshot.data!.isEmpty
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/search.svg', width: 180),
                      const Text(
                        'No Expense Added Yet!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: 'RedHatMono',
                        ),
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    ExpenseModel expense = snapshot.data![index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(expense.category == 'Media'
                            ? Ionicons.image_outline
                            : expense.category == 'Others'
                                ? Icons.money_outlined
                                : FluentSystemIcons.ic_fluent_home_regular),
                      ),
                      title: Text(expense.item),
                      subtitle: Text(
                        formatDateTime(
                          convertTimestampToDateTime(expense.createdAt.seconds),
                        ),
                      ),
                      trailing: Text(
                        '-${formatMoney(expense.cost)}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  },
                );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            si.routerService.nextRoute(context, const AddExpense()),
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
