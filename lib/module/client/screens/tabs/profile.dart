import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/module/client/screens/tabs/profile/settings.dart';
import 'package:u_arewa_studio/module/client/screens/tabs/profile/user_info.dart';
import 'package:u_arewa_studio/shared/auth/signin.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/model/user_model.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';
import 'package:u_arewa_studio/shared/widgets/buttons/primary_raised_button.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
        future: si.userService
            .getSingleUser(id: currentUser.uid, uid: currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitThreeBounce(
                color: AppColors.primaryColor,
                size: 30.0,
              ),
            );
          } else if (snapshot.hasError) {
            Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text(
                '😕Ops!Check your internet Connection!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'RedHatMono',
                ),
              ),
            );
          }
          UserModel? user = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
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
                      backgroundColor: const Color(0xFF446DBF).withOpacity(0.7),
                      radius: 45,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  user!.displayName,
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
                    user.status,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () => si.routerService.nextRoute(
                          context,
                          UserInfo(user: user),
                        ),
                        leading: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF446DBF).withOpacity(0.7),
                          ),
                          child: const Icon(
                            Ionicons.person_outline,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text(
                          'Profile',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      ListTile(
                        onTap: () => si.routerService
                            .nextRoute(context, const Settings()),
                        leading: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF446DBF).withOpacity(0.7),
                          ),
                          child: const Icon(
                            Ionicons.lock_closed_outline,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text(
                          'Settings',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF446DBF).withOpacity(0.7),
                          ),
                          child: const Icon(
                            Ionicons.notifications_outline,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text(
                          'Notifications',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF446DBF).withOpacity(0.7),
                          ),
                          child: const Icon(
                            Icons.access_time,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text(
                          'History',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF446DBF).withOpacity(0.7),
                          ),
                          child: const Icon(
                            Icons.insert_drive_file_outlined,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text(
                          'Terms & Conditions',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 50),
                      PrimaryButton(
                          onTap: (s, st, b) {
                            si.routerService.popUntil(
                              context,
                              const Signin(),
                            );
                          },
                          buttonTitle: 'Logout'),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
