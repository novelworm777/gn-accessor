import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gn_accessor/services/user.dart';

class Market {
  static const String collectionName = 'products';

  final CollectionReference<Map<String, dynamic>> _db =
      FirebaseFirestore.instance.collection(User.collectionName);

  /// Get all products sold in market sort by price (ascending).
  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts(String uid) {
    return _db
        .doc(uid)
        .collection(collectionName)
        .orderBy('price', descending: false)
        .snapshots();
  }
}
