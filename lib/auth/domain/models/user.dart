class User {
  String? uid;
  String? name;
  int? cryois;

  User.create(String id, Map<String, dynamic> map) {
    uid = id;
    name = map['name'];
    cryois = map['cryois'];
  }
}
