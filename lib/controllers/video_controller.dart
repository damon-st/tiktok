import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/constant.dart';
import 'package:tiktok/models/video.dart';
import 'package:tiktok/views/screnns/comment_screen.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList
        .bindStream(firestore.collection("videos").snapshots().map((query) {
      List<Video> retVal = [];
      for (var item in query.docs) {
        retVal.add(Video.fromSnap(item));
      }
      return retVal;
    }));
  }

  void likeVideo(String id) async {
    DocumentSnapshot doc = await firestore.collection("videos").doc(id).get();
    var uid = authController.user.uid;
    if ((doc.data() as dynamic)["likes"].contains(uid)) {
      await firestore.collection("videos").doc(id).update({
        "likes": FieldValue.arrayRemove([uid])
      });
    } else {
      await firestore.collection("videos").doc(id).update({
        "likes": FieldValue.arrayUnion([uid])
      });
    }
  }

  void comentVide(String id) async {
    await Get.to(() => const CommetScreen(), arguments: id);
  }
}
