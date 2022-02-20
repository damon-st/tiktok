import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username, comment, profilePhoto, uid, id;
  final datePublished;
  List likes;

  Comment({
    required this.comment,
    required this.datePublished,
    required this.id,
    required this.likes,
    required this.profilePhoto,
    required this.username,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "comment": comment,
        "profilePhoto": profilePhoto,
        "uid": uid,
        "id": id,
        "datePublished": datePublished,
        "likes": likes,
      };

  static Comment fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Comment(
        comment: snap["comment"],
        datePublished: snap["datePublished"],
        id: snap["id"],
        likes: snap["likes"],
        profilePhoto: snap["profilePhoto"],
        username: snap["username"],
        uid: snap["uid"]);
  }
}
