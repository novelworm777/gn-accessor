import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DocumentSnapshot> login({required String uid}) async {
    return await _db.collection("users").doc(uid).get();
  }
}
