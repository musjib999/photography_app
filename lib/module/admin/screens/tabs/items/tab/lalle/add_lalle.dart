import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/helper/form_helper.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/model/item_model.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';
import 'package:u_arewa_studio/shared/widgets/buttons/primary_raised_button.dart';

import '../../../../../../../shared/model/user_model.dart';
import '../../../../../../../shared/widgets/buttons/round_outline_icon_button.dart';
import '../../../../../../../shared/widgets/forms/type_ahead.dart';

class AddItem extends StatefulWidget {
  final String item;
  const AddItem({Key? key, required this.item}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  UserModel? client;
  int quantity = 1;
  TextEditingController amount = TextEditingController();
  TextEditingController price = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [amount, price];
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'Lalle',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Add ${widget.item}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'RedHatMono',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TypeAheadForm(
                  hintText: client == null ? 'Client' : client!.displayName,
                  onSuggestionSelected: (clients) {
                    setState(() {
                      client = clients;
                    });
                  },
                  suggestionsCallback: si.userService.getAllClientSuggestion,
                  itemBuilder: (context, item) {
                    return ListTile(
                      title: Text(item.displayName),
                      subtitle: Text(item.email),
                    );
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: widget.item,
                    suffixIcon: const Icon(Ionicons.cart_outline),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quantity',
                      style: TextStyle(color: Colors.grey),
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
                  controller: price,
                  decoration: const InputDecoration(
                    labelText: 'Item Price',
                    suffixIcon: Icon(Ionicons.cash_outline),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  controller: amount,
                  decoration: const InputDecoration(
                    labelText: 'Amount Paid',
                    suffixIcon: Icon(Ionicons.cash_outline),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15.0),
                PrimaryButton(
                  onTap: (startLoading, stopLoading, btnState) async {
                    if (_formKey.currentState!.validate()) {
                      startLoading();
                      await si.itemService
                          .addItem(
                        managerId: uid,
                        userId: client!.uid,
                        purchasedItem: widget.item,
                        quantity: quantity,
                        price: int.parse(price.text),
                        amountPaid: int.parse(amount.text),
                      )
                          .then((value) {
                        if (value.runtimeType == ItemModel) {
                          setState(() {
                            clearFormFields(controllers);
                            client = null;
                            quantity = 1;
                          });

                          si.dialogService.showToast('Item added successfully');
                          stopLoading();
                        } else {
                          stopLoading();
                          si.dialogService.showToast(value);
                        }
                      });
                    }
                  },
                  buttonTitle: 'Add',
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
