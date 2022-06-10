import 'package:flutter/material.dart';
import 'package:u_arewa_studio/module/admin/screens/pages.dart';
import 'package:u_arewa_studio/module/manager/screens/pages.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';

import '../../shared/widgets/bottomNav/home_bottom_nav.dart';

class AdminApp extends StatefulWidget {
  const AdminApp({Key? key}) : super(key: key);

  @override
  _AdminAppState createState() => _AdminAppState();
}

class _AdminAppState extends State<AdminApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'U-Arewa Studio Admin',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        primarySwatch: Colors.blue,
      ),
      home: HomeBottomNavigation(
        pages: currentUser.role == 'admin' ? adminPages : managerPages,
      ),
    );
  }
}
