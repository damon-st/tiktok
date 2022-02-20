import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/controllers/upload_video_controller.dart';
import 'package:tiktok/controllers/video_controller.dart';
import 'package:tiktok/utils/show_dialog.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

class ConfirmVideoController extends GetxController {
  late XFile filePath;
  late File file;

  late VideoPlayerController controller;

  final songController = TextEditingController();
  final captionController = TextEditingController();

  late UploadVideoController uploadVideoController;
  RxBool cargando = false.obs;

  @override
  void onInit() {
    super.onInit();
    uploadVideoController = UploadVideoController();
    filePath = Get.arguments as XFile;
    file = File(filePath.path);
    controller = VideoPlayerController.file(file);
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void onClose() {
    captionController.dispose();
    controller.dispose();
    cargando.close();
    songController.dispose();
    uploadVideoController.onClose();
    super.onClose();
  }

  void subirVideo(String songName, String caption, String videoPath) async {
    cargando.value = true;
    bool result =
        await uploadVideoController.uploadVide(songName, caption, videoPath);
    if (result) {
      cargando.value = false;
      Get.snackbar("Success", "Your video is uploading succefuly ");
    } else {
      cargando.value = false;

      Get.snackbar("Error",
          "Error while upload a video, shonting wrong, try later please");
    }
  }

  Future<bool> onWillPop() async {
    if (cargando.value) {
      bool result = await showCustomDialog(
          "Cancelar operacion?", "Estas seguro que deseas cancelar");
      print(result);
      if (result) {
        await VideoCompress.cancelCompression();
        await VideoCompress.deleteAllCache();
        cargando.value = false;
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}
