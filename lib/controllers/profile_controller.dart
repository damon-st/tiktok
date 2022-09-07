import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/constant.dart';

class ProfileController extends GetxController {
  String id;
  ProfileController(this.id);

  final RxMap<String, dynamic> _user = RxMap<String, dynamic>({});
  Map<String, dynamic> get user => _user;

  final RxString _uid = "".obs;
  bool cargando = true;

  @override
  void onInit() {
    super.onInit();
    updateUserId(id);
  }

  @override
  void onClose() {
    _user.close();
    _uid.close();
    super.onClose();
  }

  void updateUserId(String id) {
    _uid.value = id;
    getUserData();
  }

  void getUserData() async {
    List<String> thumbnails = [];
    QuerySnapshot myVideos = await firestore
        .collection("videos")
        .where("uid", isEqualTo: _uid.value)
        .get();

    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (var item in myVideos.docs) {
      thumbnails.add((item.data() as dynamic)["thumbnail"]);
      likes += ((item.data() as dynamic)["likes"] as List).length;
    }
    DocumentSnapshot documentSnapshot =
        await firestore.collection("users").doc(_uid.value).get();
    final data = documentSnapshot.data() as dynamic;
    String name = data["name"] ?? "User";
    String profilePhoto = data["profilePhto"] ??
        "https://i.postimg.cc/nVRrJTrR/annie-spratt-5-ABow0u-Vv-k-unsplash-1.jpg";

    var followerDoc = await firestore
        .collection("users")
        .doc(_uid.value)
        .collection("followers")
        .get();
    var followingDoc = await firestore
        .collection("users")
        .doc(_uid.value)
        .collection("following")
        .get();

    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    firestore
        .collection("users")
        .doc(_uid.value)
        .collection("followers")
        .doc(authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      "followers": followers.toString(),
      "following": following.toString(),
      "isFollowing": isFollowing,
      "likes": likes.toString(),
      "profilePhoto": profilePhoto,
      "name": name,
      "thumbnails": thumbnails,
    };
    cargando = false;
    update();
  }

  void singOut() async {
    await firebaseAuth.signOut();
  }

  void follorUser() async {
    var doc = await firestore
        .collection("users")
        .doc(_uid.value)
        .collection("followers")
        .doc(authController.user.uid)
        .get();

    if (!doc.exists) {
      await firestore
          .collection("users ")
          .doc(_uid.value)
          .collection("followers")
          .doc(authController.user.uid)
          .set({});
      await firestore
          .collection("users ")
          .doc(authController.user.uid)
          .collection("followers")
          .doc(_uid.value)
          .set({});
      _user.update("followers", (value) => (int.parse(value) + 1).toString());
    } else {
      await firestore
          .collection("users ")
          .doc(_uid.value)
          .collection("followers")
          .doc(authController.user.uid)
          .delete();
      await firestore
          .collection("users ")
          .doc(authController.user.uid)
          .collection("followers")
          .doc(_uid.value)
          .delete();
      _user.update("followers", (value) => (int.parse(value) - 1).toString());
    }
    _user.update("isFollowing", (value) => !value);
    update();
  }
}
