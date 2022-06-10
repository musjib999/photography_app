import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/module/client/screens/pages.dart';
import 'package:u_arewa_studio/shared/widgets/bottomNav/home_bottom_nav.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<bool?> checkForPermission() async {
    bool? hasAllowed;
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      hasAllowed = isAllowed;
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    return hasAllowed;
  }

  notificationTap(BuildContext context) {
    return AwesomeNotifications()
        .actionStream
        .listen((ReceivedNotification receivedNotification) {
      si.routerService.nextRoute(
        context,
        HomeBottomNavigation(pages: clientPages),
      );
    });
  }

  showNotification({
    int id = 1,
    String? title,
    String? body,
  }) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'u_arewa_studio',
        title: title,
        body: body,
      ),
    );
  }
  // showNotification({
  //   int id = 0,
  //   String? title,
  //   String? body,
  //   String? payload,
  // }) {
  //   notificationsPlugin.show(
  //     id,
  //     title,
  //     body,
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails('Channel Id', 'Channel Name',
  //           importance: Importance.max),
  //       iOS: IOSNotificationDetails(),
  //     ),
  //   );
  // }
}
