import 'package:flutter/material.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/helper/date_helper.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/model/staff_model.dart';
import 'package:u_arewa_studio/shared/model/user_model.dart';
import 'package:u_arewa_studio/shared/widgets/cards/media_card.dart';
import 'package:u_arewa_studio/shared/widgets/cards/user_card.dart';

import '../../../../../../../shared/model/makeup_model.dart';
import '../../../../../../../shared/themes/colors.dart';

class SingleMakeup extends StatefulWidget {
  final MakeupModel makeup;
  const SingleMakeup({Key? key, required this.makeup}) : super(key: key);

  @override
  _SingleMakeupState createState() => _SingleMakeupState();
}

class _SingleMakeupState extends State<SingleMakeup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Container(
          margin: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              MediaCard(
                timestamp:
                    convertTimestampToDateTime(widget.makeup.createdAt.seconds),
                pictureType: widget.makeup.makeupType,
                status: widget.makeup.status,
                price: widget.makeup.price,
                amountpaid: widget.makeup.amountPaid,
                pendingBalance: widget.makeup.pendingBalance,
                link: '',
              ),
              const SizedBox(height: 15.0),
              role != 'client'
                  ? FutureBuilder<UserModel?>(
                      future: si.userService.getSingleUser(
                          id: widget.makeup.userId, uid: currentUser.uid),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const UserCard(
                            title: 'Client Information',
                            displayName: 'Loading...',
                            status: 'loading...',
                            email: 'loading...',
                            phone: 'loading...',
                            role: 'loading...',
                          );
                        }
                        UserModel? user = snapshot.data;
                        return UserCard(
                          title: 'Client Information',
                          displayName: user == null ? 'N/A' : user.displayName,
                          status: user == null ? 'N/A' : user.status,
                          email: user == null ? 'N/A' : user.email,
                          phone: user == null ? 'N/A' : user.phone,
                          role: user == null ? 'N/A' : user.role,
                        );
                      }),
                    )
                  : Container(),
              const SizedBox(height: 15.0),
              FutureBuilder<UserModel?>(
                future: si.userService.getSingleUser(
                    id: widget.makeup.managerId, uid: currentUser.uid),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const UserCard(
                      title: 'Manager Information',
                      displayName: 'Loading...',
                      status: 'loading...',
                      email: 'loading...',
                      phone: 'loading...',
                      role: 'loading...',
                    );
                  }
                  UserModel? user = snapshot.data;
                  return UserCard(
                    title: 'Manager Information',
                    displayName: user == null ? 'N/A' : user.displayName,
                    status: user == null ? 'N/A' : user.status,
                    email: user == null ? 'N/A' : user.email,
                    phone: user == null ? 'N/A' : user.phone,
                    role: user == null ? 'N/A' : user.role,
                  );
                }),
              ),
              const SizedBox(height: 15.0),
              FutureBuilder<StaffModel?>(
                future: si.userService.getSingleStaff(widget.makeup.staffId),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const UserCard(
                      title: 'Staff Information',
                      displayName: 'Loading...',
                      status: 'loading...',
                      email: 'loading...',
                      phone: 'loading...',
                      role: 'loading...',
                    );
                  }
                  StaffModel? user = snapshot.data;
                  return UserCard(
                    title: 'Staff Information',
                    displayName: user == null ? 'N/A' : user.displayName,
                    status: user == null ? 'N/A' : user.status,
                    email: user == null ? 'N/A' : user.email,
                    phone: user == null ? 'N/A' : user.phone,
                    role: user == null ? 'N/A' : user.role,
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
