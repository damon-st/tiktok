import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name, profilePhoto, email, uuid;
  User(
      {required this.email,
      required this.name,
      required this.profilePhoto,
      required this.uuid});

  Map<String, dynamic> toJson() =>
      {"name": name, "profilePhto": profilePhoto, "email": email, "uuid": uuid};

  static User fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return User(
        email: snap["email"],
        name: snap["name"],
        profilePhoto: snap["profilePhto"],
        uuid: snap["uuid"]);
  }
}
