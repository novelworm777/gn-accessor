import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gn_accessor/services/user.dart';
import 'package:gn_accessor/utils/map_utils.dart';

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

  /// Create a new product.
  void addProduct(String uid, Map<String, dynamic> raw) async {
    // clean raw data from null and empty string
    final product = MapUtils.clean(raw);

    // add new entries according to raw data
    product['price'] = raw['price'] != null && raw['price'] != ''
        ? int.parse(raw['price'])
        : 0;

    // create new document
    _db.doc(uid).collection(collectionName).add(product);
  }
}
