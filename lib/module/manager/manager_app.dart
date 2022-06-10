import 'package:flutter/material.dart';
import 'package:u_arewa_studio/module/manager/screens/pages.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';

import '../../shared/widgets/bottomNav/home_bottom_nav.dart';

class ManagerApp extends StatefulWidget {
  const ManagerApp({Key? key}) : super(key: key);

  @override
  _ManagerAppState createState() => _ManagerAppState();
}

class _ManagerAppState extends State<ManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'U-Arewa Studio',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        primarySwatch: Colors.blue,
      ),
      home: HomeBottomNavigation(pages: managerPages),
    );
  }
}
