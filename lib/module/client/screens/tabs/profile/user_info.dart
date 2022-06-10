import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/shared/widgets/buttons/primary_raised_button.dart';
import '../../../../../helper/form_helper.dart';
import '../../../../../shared/model/media_model.dart';
import '../../../../../shared/model/user_model.dart';
import '../../../../../shared/themes/colors.dart';

class UserInfo extends StatefulWidget {
  final UserModel user;
  const UserInfo({Key? key, required this.user}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool enableFields = false;
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [fName, lName, phone];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.bgColor,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                enableFields = true;
                fName.text = widget.user.firstName;
                lName.text = widget.user.lastName;
                phone.text = widget.user.phone;
              });
            },
            icon: const Icon(FluentSystemIcons.ic_fluent_edit_filled),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.3),
                        width: 4.0,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage:
                          const AssetImage('assets/images/profile.png'),
                      backgroundColor: const Color(0xFF446DBF).withOpacity(0.7),
                      radius: 35,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.displayName,
                        style: const TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(3)),
                        child: Text(
                          widget.user.status,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'First Name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  TextField(
                    controller: fName,
                    enabled: enableFields,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      fillColor: enableFields == true
                          ? AppColors.bgColor
                          : AppColors.primaryColor.withOpacity(0.3),
                      filled: true,
                      hintText: widget.user.firstName,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Last Name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  TextField(
                    controller: lName,
                    enabled: enableFields,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      fillColor: enableFields == true
                          ? AppColors.bgColor
                          : AppColors.primaryColor.withOpacity(0.3),
                      filled: true,
                      hintText: widget.user.lastName,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      fillColor: AppColors.primaryColor.withOpacity(0.3),
                      filled: true,
                      hintText: widget.user.email,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phone',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  TextField(
                    controller: phone,
                    enabled: enableFields,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      fillColor: enableFields == true
                          ? AppColors.bgColor
                          : AppColors.primaryColor.withOpacity(0.3),
                      filled: true,
                      hintText: widget.user.phone,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              enableFields == true
                  ? PrimaryButton(
                      onTap: (startLoading, stopLoading, btnState) async {
                        startLoading();
                        await si.userService
                            .updateUserInfo(
                                id: widget.user.uid,
                                fName: fName.text,
                                lName: lName.text,
                                phone: phone.text)
                            .then((value) {
                          if (value.runtimeType == UpdateMediaModel) {
                            clearFormFields(controllers);
                            stopLoading();
                            si.dialogService
                                .showToast('Profile has been updated');
                          } else {
                            si.dialogService.showToast(value);
                            stopLoading();
                          }
                        });
                      },
                      buttonTitle: 'Update',
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
