import 'package:flutter/material.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/helper/date_helper.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/model/item_model.dart';
import 'package:u_arewa_studio/shared/model/user_model.dart';
import 'package:u_arewa_studio/shared/widgets/cards/media_card.dart';
import 'package:u_arewa_studio/shared/widgets/cards/user_card.dart';
import '../../../../../../../shared/themes/colors.dart';

class SingleTurare extends StatefulWidget {
  final ItemModel turare;
  const SingleTurare({Key? key, required this.turare}) : super(key: key);

  @override
  _SingleTurareState createState() => _SingleTurareState();
}

class _SingleTurareState extends State<SingleTurare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'turare',
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
                    convertTimestampToDateTime(widget.turare.createdAt.seconds),
                pictureType: 'turare',
                status: 'Purchased',
                price: widget.turare.price,
                amountpaid: widget.turare.amountPaid,
                pendingBalance: widget.turare.pendingBalance,
                link: '',
              ),
              const SizedBox(height: 15.0),
              role != 'client'
                  ? FutureBuilder<UserModel?>(
                      future: si.userService.getSingleUser(
                          id: widget.turare.userId, uid: currentUser.uid),
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
                    id: widget.turare.managerId, uid: currentUser.uid),
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
            ],
          ),
        ),
      ),
    );
  }
}
