import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';
import 'package:u_arewa_studio/shared/widgets/buttons/primary_raised_button.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Text(
                  'Reset Your password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter your registered email below to reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                SvgPicture.asset('assets/svg/password.svg', width: 400),
                const SizedBox(height: 20),
                TextFormField(
                  controller: email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    } else if (!value.contains('@') ||
                        !value.contains('.com')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Ionicons.mail_outline),
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
                const SizedBox(height: 30),
                PrimaryButton(
                  onTap: (startLoading, stopLoading, btnState) async {
                    if (_formKey.currentState!.validate()) {
                      startLoading();
                      await si.firebaseService
                          .reset(email.text.trim())
                          .then((value) {
                        stopLoading();
                        if (value == true) {
                          email.clear();
                          si.routerService.popRoute(context);
                        }
                      });
                    }
                  },
                  borderRadius: 50.0,
                  buttonTitle: 'Reset',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
