import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? _id;
  String? _title;
  int? _price;

  Product.create(QueryDocumentSnapshot doc) {
    Map<dynamic, dynamic> data = doc.data() as Map;
    _id = doc.id;
    _title = data['title'] ?? '<< No Title >>';
    _price = data['price'] ?? -1;
  }

  String get id => _id!;
  String get title => _title!;
  int get price => _price!;
}
