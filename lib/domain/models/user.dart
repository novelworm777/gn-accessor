/// User domain model.
class User {
  String id;
  String? uid;
  String? name;
  int? cryois;

  /// Creates [User] from an id and a map.
  User.create(this.id, Map<String, dynamic> map) {
    uid = map['uid'];
    name = map['name'];
    cryois = map['cryois'];
  }
}
