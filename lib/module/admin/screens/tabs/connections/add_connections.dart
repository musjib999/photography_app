import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/helper/form_helper.dart';
import 'package:u_arewa_studio/shared/model/connection_model.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';
import 'package:u_arewa_studio/shared/widgets/buttons/primary_raised_button.dart';

class AddConnection extends StatefulWidget {
  const AddConnection({Key? key}) : super(key: key);

  @override
  _AddConnectionState createState() => _AddConnectionState();
}

class _AddConnectionState extends State<AddConnection> {
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController connection = TextEditingController();
  TextEditingController period = TextEditingController();
  TextEditingController amount = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [
      fName,
      lName,
      email,
      phone,
      connection,
      period,
      amount
    ];
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'Connection',
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
                    'Add Connection',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'RedHatMono',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                  controller: fName,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    suffixIcon: Icon(Ionicons.person_outline),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                  controller: lName,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    suffixIcon: Icon(Ionicons.person_outline),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    } else if (!value.contains('@') || !value.contains('.')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    suffixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    } else if (value[0] != '+') {
                      return 'Phone number should be in +234 pattern';
                    }
                    return null;
                  },
                  controller: phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    suffixIcon: Icon(Icons.phone_outlined),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter connection';
                    }
                    return null;
                  },
                  controller: connection,
                  decoration: const InputDecoration(
                    labelText: 'Connection',
                    suffixIcon: Icon(Icons.phone_outlined),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter duration';
                    }
                    return null;
                  },
                  controller: period,
                  decoration: const InputDecoration(
                    labelText: 'Duration',
                    suffixIcon: Icon(Ionicons.time_outline),
                  ),
                  keyboardType: TextInputType.text,
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
                    labelText: 'Amount',
                    suffixIcon: Icon(Ionicons.cash_outline),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 15.0),
                PrimaryButton(
                  onTap: (startLoading, stopLoading, btnState) async {
                    if (_formKey.currentState!.validate()) {
                      startLoading();
                      await si.authService
                          .creatConnection(
                        fName: fName.text,
                        lName: lName.text,
                        email: email.text,
                        phone: phone.text,
                        conn: connection.text,
                        amount: int.parse(amount.text),
                        period: period.text,
                      )
                          .then((value) {
                        if (value.runtimeType == ConnectionModel) {
                          ConnectionModel conn = value;
                          si.dialogService.showToast(
                            '${conn.displayName} has been add to connections',
                          );
                          stopLoading();
                          clearFormFields(controllers);
                        } else {
                          stopLoading();
                          si.dialogService.showToast(value);
                        }
                      });
                    }
                  },
                  buttonTitle: 'Register',
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
