import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username,
      uid,
      id,
      songname,
      caption,
      videoUrl,
      thumbnail,
      profilePhoto;
  List likes;
  int commentCount, shareCount;

  Video({
    required this.caption,
    required this.commentCount,
    required this.id,
    required this.likes,
    required this.profilePhoto,
    required this.shareCount,
    required this.songname,
    required this.thumbnail,
    required this.uid,
    required this.username,
    required this.videoUrl,
  });

  Map<String, dynamic> toJson() => {
        "caption": caption,
        "commentCount": commentCount,
        "id": id,
        "likes": likes,
        "profilePhoto": profilePhoto,
        "shareCount": shareCount,
        "songname": songname,
        "thumbnail": thumbnail,
        "uid": uid,
        "username": username,
        "videoUrl": videoUrl
      };

  static Video fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Video(
        caption: snap["caption"],
        commentCount: snap["commentCount"],
        id: snap["id"],
        likes: snap["likes"],
        profilePhoto: snap["profilePhoto"],
        shareCount: snap["shareCount"],
        songname: snap["songname"],
        thumbnail: snap["thumbnail"],
        uid: snap["uid"],
        username: snap["username"],
        videoUrl: snap["videoUrl"]);
  }
}
