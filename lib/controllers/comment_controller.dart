import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tiktok/constant.dart';
import 'package:tiktok/models/comment.dart';
import 'package:tiktok/models/user.dart';

class CommentController extends GetxController {
  final textController = TextEditingController();

  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;
  String _postId = "";

  @override
  void onInit() {
    super.onInit();
    uploadPostId(Get.arguments as String);
  }

  void uploadPostId(String id) {
    _postId = id;
    print(_postId);
    getComment();
  }

  void getComment() async {
    _comments.bindStream(firestore
        .collection("videos")
        .doc(_postId)
        .collection("comments")
        .snapshots()
        .map((query) {
      List<Comment> retValue = [];
      for (var item in query.docs) {
        retValue.add(Comment.fromSnap(item));
      }
      return retValue;
    }));
  }

  void postCommnet(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot snapshot = await firestore
            .collection("users")
            .doc(authController.user.uid)
            .get();
        User user = User.fromSnap(snapshot);
        var allDocs = await firestore
            .collection("videos")
            .doc(_postId)
            .collection("comments")
            .get();

        int len = allDocs.docs.length;

        Comment comment = Comment(
            comment: commentText.trim(),
            datePublished: DateTime.now(),
            id: "Comment $len",
            likes: [],
            profilePhoto: user.profilePhoto,
            username: user.name,
            uid: user.uuid);
        await firestore
            .collection("videos")
            .doc(_postId)
            .collection("comments")
            .doc("Comment $len")
            .set(comment.toJson());

        DocumentSnapshot doc =
            await firestore.collection("videos").doc(_postId).get();
        await firestore.collection("videos").doc(_postId).update(
            {"commentCount": (doc.data() as dynamic)["commentCount"] + 1});
        textController.clear();
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    }
  }

  void likeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore
        .collection("videos")
        .doc(_postId)
        .collection("comments")
        .doc(id)
        .get();
    if ((doc.data() as dynamic)["likes"].contains(uid)) {
      await firestore
          .collection("videos")
          .doc(_postId)
          .collection("comments")
          .doc(id)
          .update({
        "likes": FieldValue.arrayRemove([uid])
      });
    } else {
      await firestore
          .collection("videos")
          .doc(_postId)
          .collection("comments")
          .doc(id)
          .update({
        "likes": FieldValue.arrayUnion([uid])
      });
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
