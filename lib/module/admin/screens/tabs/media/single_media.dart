import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/helper/date_helper.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/media/edit_media.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/model/media_model.dart';
import 'package:u_arewa_studio/shared/model/staff_model.dart';
import 'package:u_arewa_studio/shared/model/user_model.dart';
import 'package:u_arewa_studio/shared/widgets/cards/media_card.dart';
import 'package:u_arewa_studio/shared/widgets/cards/user_card.dart';

import '../../../../../shared/themes/colors.dart';

class SingleMedia extends StatefulWidget {
  final String? id;
  final MediaModel media;
  const SingleMedia({Key? key, required this.media, this.id}) : super(key: key);

  @override
  _SingleMediaState createState() => _SingleMediaState();
}

class _SingleMediaState extends State<SingleMedia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'Media',
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
                    convertTimestampToDateTime(widget.media.createdAt.seconds),
                pictureType: widget.media.pictureType,
                status: widget.media.status,
                price: widget.media.picturePrice,
                amountpaid: widget.media.amountPaid,
                pendingBalance: widget.media.pendingBalance,
                link: widget.media.link,
              ),
              const SizedBox(height: 15.0),
              role != 'client'
                  ? FutureBuilder<UserModel?>(
                      future: si.userService.getSingleUser(
                          id: widget.media.userId, uid: currentUser.uid),
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
                    id: widget.media.managerId, uid: currentUser.uid),
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
                future: si.userService.getSingleStaff(widget.media.staffId),
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
      floatingActionButton: currentUser.role != 'client'
          ? FloatingActionButton(
              onPressed: () => si.routerService.nextRoute(
                context,
                EditMedia(
                  media: widget.media,
                  id: widget.id ?? '',
                ),
              ),
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Ionicons.pencil_outline),
            )
          : Container(),
    );
  }
}
