import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:u_arewa_studio/shared/auth/signin.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'u_arewa_studio',
        channelName: 'Unlock arewa studio channel',
        channelDescription: 'Unlock arewa studio media notification',
        defaultColor: AppColors.primaryColor,
        importance: NotificationImportance.High,
      )
    ],
    debug: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return MaterialApp(
          title: 'Unlock Arewa Studio',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Signin(),
        );
      },
    );
  }
}
