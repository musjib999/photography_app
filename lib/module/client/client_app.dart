import 'package:flutter/material.dart';
import 'package:u_arewa_studio/module/client/screens/pages.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';

import '../../core/servie_injector/si.dart';
import '../../shared/widgets/bottomNav/home_bottom_nav.dart';

class ClientApp extends StatefulWidget {
  const ClientApp({Key? key}) : super(key: key);

  @override
  _ClientAppState createState() => _ClientAppState();
}

class _ClientAppState extends State<ClientApp> {
  @override
  void initState() {
    super.initState();
    si.firebaseService.subscribeNotification();
    // si.notificationService.notificationTap(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'U-Arewa Studio',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        primarySwatch: Colors.blue,
      ),
      home: HomeBottomNavigation(pages: clientPages),
    );
  }
}
