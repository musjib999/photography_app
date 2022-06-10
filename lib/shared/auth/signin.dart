import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/module/admin/admin_app.dart';
import 'package:u_arewa_studio/module/client/client_app.dart';
import 'package:u_arewa_studio/module/client/screens/tabs/profile/settings.dart';
import 'package:u_arewa_studio/shared/auth/signup.dart';
import 'package:u_arewa_studio/shared/model/user_model.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';

import '../../core/servie_injector/si.dart';
import '../widgets/buttons/primary_raised_button.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    SvgPicture.asset('assets/svg/login.svg', width: 180),
                    const Text(
                      'Welcome Back!',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Login your existing account',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
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
                    const SizedBox(height: 15.0),
                    TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => si.routerService
                              .nextRoute(context, const Settings()),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: AppColors.textColor),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    PrimaryButton(
                      onTap: (startLoading, stopLoading, btnState) async {
                        if (_formKey.currentState!.validate()) {
                          startLoading();
                          await si.authService
                              .login(email: email.text, password: password.text)
                              .then((value) {
                            stopLoading();
                            if (value.runtimeType == UserModel) {
                              UserModel user = value;
                              if (user.role == 'client') {
                                si.routerService
                                    .popUntil(context, const ClientApp());
                              } else {
                                si.routerService
                                    .popUntil(context, const AdminApp());
                              }
                            } else {
                              si.dialogService.showToast(value);
                            }
                          });
                        }
                      },
                      buttonTitle: 'Login',
                      borderRadius: 25.0,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () =>
                        si.routerService.nextRoute(context, const Signup()),
                    child: const Text(
                      ' Register',
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
