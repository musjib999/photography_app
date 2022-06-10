import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/helper/form_helper.dart';
import 'package:u_arewa_studio/shared/auth/signin.dart';
import 'package:u_arewa_studio/shared/model/user_model.dart';

import '../../core/servie_injector/si.dart';
import '../themes/colors.dart';
import '../widgets/buttons/primary_raised_button.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [
      fName,
      lName,
      email,
      password,
      cPassword,
      phone,
    ];
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white10),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Let\'s Get Started!',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Create an account to access unlock arewa studio',
                      style: TextStyle(color: Colors.grey),
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
                    const SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm Password is required';
                        } else if (cPassword.text != password.text) {
                          return 'Passwords not matched';
                        }
                        return null;
                      },
                      controller: cPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Ionicons.lock_closed_outline),
                        hintText: 'Confirm Password',
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
                              .registerUser(
                            fName: fName.text,
                            lName: lName.text,
                            email: email.text,
                            phone: phone.text,
                            password: password.text,
                          )
                              .then((value) {
                            if (value.runtimeType == UserModel) {
                              si.dialogService.showToast(
                                  'Your account has been created successfully');
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
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () =>
                      si.routerService.nextRoute(context, const Signin()),
                  child: const Text(
                    ' Signin',
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
    );
  }
}
