import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok/constant.dart';
import 'package:tiktok/models/user.dart';
import 'package:tiktok/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  Subscription? subVideo;
  RxDouble progress = 0.0.obs;
  StreamSubscription<TaskSnapshot>? uploadVideo1;

  Future<bool> uploadVide(
      String songName, String caption, String videoPath) async {
    Completer<bool> completer = Completer();
    try {
      String uid = firebaseAuth.currentUser!.uid;
      print(uid);
      DocumentSnapshot userDoc =
          await firestore.collection("users").doc(uid).get();

      print(userDoc.data());
      User user = User.fromSnap(userDoc);
      print(user.toJson());

      var allDocs = await firestore.collection("videos").get();
      int len = allDocs.docs.length;
      final files = File(videoPath);
      int size = await files.length();
      double kb = size / 1024;
      String videoUrl = "";
      if (kb >= 30000) {
        videoUrl = await _uloadVideoToStorage("Video $len", videoPath);
      } else {
        videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      }

      subVideo?.unsubscribe();
      String thumbUrl = await _uploadImageToStorage("Video $len", videoPath);

      Video video = Video(
          caption: caption,
          commentCount: 0,
          id: "Video $len",
          likes: [],
          profilePhoto: user.profilePhoto,
          shareCount: 0,
          songname: songName,
          thumbnail: thumbUrl,
          uid: uid,
          username: user.name,
          videoUrl: videoUrl);
      await firestore
          .collection("videos")
          .doc("Video $len")
          .set(video.toJson());
      await VideoCompress.deleteAllCache();
      completer.complete(true);
    } catch (e) {
      print(e);
      completer.complete(false);
    }
    return completer.future;
  }

  Future<String> _uloadVideoToStorage(String id, String videoPath) async {
    final ref = firebaseStorage.ref().child("videos").child(id);
    UploadTask uploadTask = ref.putFile(await __compressVide(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<File> __compressVide(String videoPath) async {
    subVideo = VideoCompress.compressProgress$.subscribe((event) {
      progress.value = event;
    });
    final compresVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.HighestQuality);
    return compresVideo!.file!;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    final ref = firebaseStorage.ref().child("thumbnails").child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnails(videoPath));

    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    final ref = firebaseStorage.ref().child("videos").child(id);
    UploadTask uploadTask = ref.putFile(File(videoPath));
    uploadVideo1 = uploadTask.snapshotEvents.listen((snapshot) {
      progress.value = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
    });
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<File> _getThumbnails(String videoPath) async {
    return await VideoCompress.getFileThumbnail(videoPath);
  }

  @override
  void onClose() {
    VideoCompress.dispose();
    subVideo?.unsubscribe();
    progress.close();
    uploadVideo1?.cancel();
    print("cerando------");
    super.onClose();
  }
}
