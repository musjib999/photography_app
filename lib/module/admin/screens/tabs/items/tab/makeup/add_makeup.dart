import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/model/makeup_model.dart';
import 'package:u_arewa_studio/shared/model/staff_model.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';
import 'package:u_arewa_studio/shared/widgets/buttons/primary_raised_button.dart';

import '../../../../../../../helper/form_helper.dart';
import '../../../../../../../shared/model/user_model.dart';
import '../../../../../../../shared/widgets/buttons/round_outline_icon_button.dart';
import '../../../../../../../shared/widgets/forms/type_ahead.dart';

class AddMakeup extends StatefulWidget {
  const AddMakeup({Key? key}) : super(key: key);

  @override
  _AddMakeupState createState() => _AddMakeupState();
}

class _AddMakeupState extends State<AddMakeup> {
  UserModel? client;
  StaffModel? staff;
  int quantity = 1;
  TextEditingController makeupType = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController price = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [amount, price, makeupType];
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'Makeup',
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
                const Center(
                  child: Text(
                    'Add Makeup',
                    style: TextStyle(
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
                TypeAheadForm(
                  hintText: staff == null ? 'Staff' : staff!.displayName,
                  onSuggestionSelected: (singleStaff) {
                    setState(() {
                      staff = singleStaff;
                    });
                  },
                  suggestionsCallback:
                      si.userService.getAllStaffMakeupArtistsSuggestion,
                  itemBuilder: (context, item) {
                    return ListTile(
                      title: Text(item.displayName),
                      subtitle: Text(item.category),
                    );
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter makeup type';
                    }
                    return null;
                  },
                  controller: makeupType,
                  decoration: const InputDecoration(
                    labelText: 'Makeup Type',
                    suffixIcon: Icon(Icons.face_outlined),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Faces',
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter price';
                    }
                    return null;
                  },
                  controller: price,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    suffixIcon: Icon(Ionicons.cash_outline),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter amount paid';
                    }
                    return null;
                  },
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
                    if (client == null || staff == null) {
                      si.dialogService
                          .showToast('Please select client and staff');
                    } else {
                      if (_formKey.currentState!.validate()) {
                        startLoading();
                        si.makeupService
                            .addMakeup(
                          managerId: uid,
                          userId: client!.uid,
                          staffId: staff!.uid,
                          makeupType: makeupType.text,
                          faces: quantity,
                          amountPaid: int.parse(amount.text),
                          price: int.parse(price.text),
                        )
                            .then((value) {
                          if (value.runtimeType == MakeupModel) {
                            si.dialogService
                                .showToast('Makeup added successfully');
                            clearFormFields(controllers);
                            stopLoading();
                          } else {
                            si.dialogService.showToast(value);
                            stopLoading();
                          }
                        });
                      }
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
