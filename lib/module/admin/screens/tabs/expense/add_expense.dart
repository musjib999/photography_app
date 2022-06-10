import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/model/expense_model.dart';

import '../../../../../core/servie_injector/si.dart';
import '../../../../../helper/form_helper.dart';
import '../../../../../shared/themes/colors.dart';
import '../../../../../shared/widgets/buttons/primary_raised_button.dart';
import '../../../../../shared/widgets/buttons/round_outline_icon_button.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController managerId = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController cost = TextEditingController();
  int quantity = 1;
  String selectedCategory = '';

  List<String> category = ['Media', 'Infrastructure', 'Others'];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [managerId, item, cost];
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'Expense',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Capture Expense',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'RedHatMono',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // TextFormField(
                //   controller: managerId,
                //   decoration: const InputDecoration(
                //     labelText: 'Manager',
                //     suffixIcon: Icon(Ionicons.person_outline),
                //   ),
                // ),
                // const SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter item';
                    }
                    return null;
                  },
                  controller: item,
                  decoration: const InputDecoration(
                    labelText: 'Item',
                    suffixIcon: Icon(Ionicons.person_outline),
                  ),
                ),
                const SizedBox(height: 15.0),
                DropdownButtonFormField<dynamic>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select category';
                    }
                    return null;
                  },
                  items: getDropdownItems(category),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quantity',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(
                        children: [
                          RoundOutlinedIconButton(
                            icon: Icons.remove,
                            color: Colors.grey,
                            onPressed: quantity == 0
                                ? () {}
                                : () {
                                    setState(() {
                                      quantity--;
                                    });
                                  },
                          ),
                          const SizedBox(width: 8.0),
                          Text('$quantity'),
                          const SizedBox(width: 8.0),
                          RoundOutlinedIconButton(
                            icon: Icons.add,
                            color: Colors.grey,
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter cost';
                    }
                    return null;
                  },
                  controller: cost,
                  decoration: const InputDecoration(
                    labelText: 'Cost',
                    suffixIcon: Icon(Ionicons.cash_outline),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15.0),
                PrimaryButton(
                  onTap: (startLoading, stopLoading, btnState) async {
                    if (_formKey.currentState!.validate()) {
                      startLoading();
                      await si.expenseService
                          .addExpense(
                        managerId: currentUser.uid,
                        item: item.text,
                        cost: int.parse(cost.text),
                        quantity: quantity,
                        category: selectedCategory,
                      )
                          .then((value) {
                        if (value.runtimeType == ExpenseModel) {
                          ExpenseModel expense = value;
                          si.dialogService.showToast(
                            '${expense.item} has been captured',
                          );
                          stopLoading();
                          setState(() {
                            quantity = 1;
                            selectedCategory = '';
                          });
                          clearFormFields(controllers);
                        } else {
                          stopLoading();
                          si.dialogService.showToast(value);
                        }
                      });
                    }
                  },
                  buttonTitle: 'Capture',
                  borderRadius: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
