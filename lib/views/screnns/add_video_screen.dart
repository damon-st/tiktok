import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/constant.dart';
import 'package:tiktok/controllers/add_video_controller.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddVideoController>(
        init: AddVideoController(),
        builder: (controller) {
          return Scaffold(
            body: Center(
              child: InkWell(
                onTap: () {
                  controller.showOptionsDialog(context);
                },
                child: Container(
                  width: 190,
                  height: 50,
                  decoration: BoxDecoration(color: buttonColor),
                  child: const Center(
                    child: Text(
                      "Add Video",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
