import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/helper/form_helper.dart';
import 'package:u_arewa_studio/shared/model/staff_model.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';
import 'package:u_arewa_studio/shared/widgets/buttons/primary_raised_button.dart';

class AddStaff extends StatefulWidget {
  const AddStaff({Key? key}) : super(key: key);

  @override
  _AddStaffState createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  String selectedCategory = '';
  List<String> category = ['Photographer', 'Secretary', 'Makeup Artist'];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [
      fName,
      lName,
      email,
      phone,
    ];
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'Staff',
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
                    'Register Staff',
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
                const SizedBox(height: 15.0),
                PrimaryButton(
                  onTap: (startLoading, stopLoading, btnState) async {
                    if (_formKey.currentState!.validate()) {
                      startLoading();
                      await si.authService
                          .registerStaff(
                        fName: fName.text,
                        lName: lName.text,
                        email: email.text,
                        phone: phone.text,
                        category: selectedCategory,
                      )
                          .then((value) {
                        if (value.runtimeType == StaffModel) {
                          StaffModel staff = value;
                          si.dialogService.showToast(
                            '${staff.displayName} has been registered',
                          );
                          stopLoading();
                          setState(() {
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
