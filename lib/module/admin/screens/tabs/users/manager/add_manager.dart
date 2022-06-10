import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';

import '../../../../../../core/servie_injector/si.dart';
import '../../../../../../helper/form_helper.dart';
import '../../../../../../shared/model/user_model.dart';
import '../../../../../../shared/widgets/buttons/primary_raised_button.dart';

class AddManager extends StatefulWidget {
  const AddManager({Key? key}) : super(key: key);

  @override
  _AddManagerState createState() => _AddManagerState();
}

class _AddManagerState extends State<AddManager> {
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [
      fName,
      lName,
      email,
      password,
      phone
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manager',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create Manager',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RedHatMono',
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                  controller: fName,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline),
                    hintText: 'First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                  controller: lName,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline),
                    hintText: 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    } else if (!value.contains('@') ||
                        !value.contains('.com')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  controller: email,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15.0),
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
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone_outlined),
                    hintText: 'Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Ionicons.person_outline),
                    hintText: 'Role = Manager',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Ionicons.lock_closed_outline),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                  onTap: (startLoading, stopLoading, btnState) async {
                    if (_formKey.currentState!.validate()) {
                      startLoading();
                      await si.authService
                          .registerManager(
                        fName: fName.text,
                        lName: lName.text,
                        email: email.text,
                        phone: phone.text,
                        password: password.text,
                        role: 'manager',
                      )
                          .then((value) {
                        if (value.runtimeType == UserModel) {
                          si.dialogService.showToast(
                              'Manager has been created successfully');
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
                  borderRadius: 25.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
