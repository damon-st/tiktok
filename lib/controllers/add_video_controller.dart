import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/views/screnns/confirm_screnn.dart';

class AddVideoController extends GetxController {
  Future showOptionsDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () {
                  pickVideo(ImageSource.gallery, context);
                },
                child: Row(
                  children: const [
                    Icon(Icons.image),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Gallery",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  pickVideo(ImageSource.camera, context);
                },
                child: Row(
                  children: const [
                    Icon(Icons.camera),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Camera",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    Icon(Icons.cancel),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  void pickVideo(ImageSource src, BuildContext context) async {
    try {
      Navigator.pop(context);
      final video = await ImagePicker().pickVideo(source: src);
      if (video != null) {
        await Get.to(() => const ConfirmScreen(), arguments: video);
      }
    } catch (e) {
      print(e);
    }
  }
}
