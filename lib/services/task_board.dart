import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gn_accessor/utils/map_utils.dart';

class TaskBoard {
  static const String _collectionName = 'tasks';

  final CollectionReference<Map<String, dynamic>> _db =
      FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot<Map<String, dynamic>>> getTasks(String uid) {
    return _db
        .doc(uid)
        .collection(_collectionName)
        .orderBy('created_at', descending: false)
        .snapshots();
  }

  Future<DocumentReference<Map<String, dynamic>>> addTask(
      String uid, Map<String, dynamic> raw) async {
    final task = MapUtils.clean(raw, remove: ['due']);
    task['reward'] = 1;
    task['created_at'] = DateTime.now();
    return await _db.doc(uid).collection(_collectionName).add(task);
  }
}
