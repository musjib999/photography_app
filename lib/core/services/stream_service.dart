import 'package:cloud_firestore/cloud_firestore.dart';

class StreamService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> getDocStream(String collection) {
    Stream<QuerySnapshot>? snapshot;
    try {
      snapshot = firestore.collection(collection).snapshots();
    } catch (e) {
      throw 'Error occured $e';
    }
    return snapshot;
  }
}
