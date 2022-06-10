import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/model/staff_model.dart';

import '../../../../../../shared/model/media_model.dart';
import '../../../../../../shared/themes/colors.dart';
import '../../../../../../shared/widgets/cards/user_info_card.dart';

class SingleStaff extends StatefulWidget {
  final StaffModel staff;
  const SingleStaff({Key? key, required this.staff}) : super(key: key);

  @override
  _SingleStaffState createState() => _SingleStaffState();
}

class _SingleStaffState extends State<SingleStaff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.primaryColor.withOpacity(0.3),
                            width: 4.0),
                      ),
                      child: CircleAvatar(
                        backgroundImage:
                            const AssetImage('assets/images/profile.png'),
                        backgroundColor:
                            const Color(0xFF446DBF).withOpacity(0.7),
                        radius: 45,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.staff.displayName,
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
                          widget.staff.status,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              widget.staff.category == 'Photographer'
                  ? FutureBuilder<List<MediaModel>>(
                      future: si.mediaService.getAllMedia(
                          '$baseUrl/getMediaByStaff?id=${widget.staff.uid}'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.blue[100],
                                    radius: 25,
                                    child: const Icon(
                                      Icons.people_outline,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text('Clients'),
                                ],
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.green[100],
                                    radius: 25,
                                    child: const Icon(
                                      Ionicons.image_outline,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${widget.staff.pictures}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text('Pictures'),
                                ],
                              ),
                            ],
                          );
                        }
                        List<MediaModel>? media = snapshot.data;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue[100],
                                  radius: 25,
                                  child: const Icon(
                                    Icons.people_outline,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  // ignore: unnecessary_null_comparison
                                  '${media == null ? '0' : media.length}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text('Clients'),
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.green[100],
                                  radius: 25,
                                  child: const Icon(
                                    Ionicons.image_outline,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.staff.pictures.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text('Pictures'),
                              ],
                            ),
                          ],
                        );
                      })
                  : Container(),
              widget.staff.category == 'Photographer'
                  ? const SizedBox(height: 25.0)
                  : Container(),
              UserInfoCard(
                title: 'Staff Information',
                fName: widget.staff.firstName,
                lName: widget.staff.lastName,
                status: widget.staff.status,
                email: widget.staff.email,
                phone: widget.staff.phone,
                category: widget.staff.category,
                connection: '',
                period: '',
                amount: '',
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
