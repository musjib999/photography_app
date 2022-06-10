import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';

class FirebaseService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late AndroidNotificationChannel channel;

  Future login({required String email, required String password}) async {
    dynamic id;
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        id = value.user!.uid;
      });
    } catch (err) {
      id = err;
    }
    return id;
  }

  Future getAllDoc(String collection) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? documets;
    try {
      await firestore
          .collection(collection)
          .orderBy('name')
          .get()
          .then((value) {
        documets = value.docs;
      });
    } catch (e) {
      documets = [];
      throw 'Error occured $e';
    }
    return documets;
  }

  Future getOneDoc({required String collection, required String id}) async {
    DocumentSnapshot<Map<String, dynamic>>? document;
    try {
      await firestore.collection(collection).doc(id).get().then((value) {
        document = value;
      });
    } catch (e) {
      throw 'Error occured $e';
    }
    return document;
  }

  Future<bool?> reset(String email) async {
    bool? hasSentEmail;
    try {
      await auth.sendPasswordResetEmail(email: email).then((value) {
        hasSentEmail = true;
        si.dialogService.showToast('Reset email has been sent');
      });
    } on FirebaseAuthException catch (error) {
      hasSentEmail = false;
      si.dialogService.showToast(error.message ?? '');
    }
    return hasSentEmail;
  }

  //Notification
  Future subscribeNotification() async {
    await messaging
        .requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    )
        .then((value) async {
      await messaging.subscribeToTopic('unlockArewa');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final messageObj = message.data;
        int id = 0;
        currentUser.uid == messageObj['userId']
            ? si.notificationService.showNotification(
                id: id++,
                title: messageObj['title'],
                body: messageObj['body'],
              )
            : null;
      });
    });
  }
}
