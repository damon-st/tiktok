import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/controllers/confirm_video_controller.dart';
import 'package:tiktok/views/widgets/background_loading.dart';
import 'package:tiktok/views/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfirmVideoController>(
        init: ConfirmVideoController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: controller.onWillPop,
            child: Stack(
              children: [
                Scaffold(
                  body: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: Get.width,
                            height: Get.height / 1.5,
                            child: AspectRatio(
                              aspectRatio:
                                  controller.controller.value.aspectRatio,
                              child: InkWell(
                                onTap: () {
                                  if (controller.controller.value.isPlaying) {
                                    controller.controller.pause();
                                  } else {
                                    controller.controller.play();
                                  }
                                },
                                child: VideoPlayer(
                                  controller.controller,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width: Get.width - 20,
                                  child: TextInputField(
                                    controller: controller.songController,
                                    labelText: "Song Name",
                                    icon: Icons.music_note,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width: Get.width - 20,
                                  child: TextInputField(
                                    controller: controller.captionController,
                                    labelText: "Caption",
                                    icon: Icons.music_note,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.subirVideo(
                                        controller.songController.text,
                                        controller.captionController.text,
                                        controller.filePath.path);
                                  },
                                  child: const Text(
                                    "Share!",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return controller.cargando.value
                      ? SizedBox(
                          width: Get.width,
                          height: Get.height,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const BackgroundLoading(),
                              Obx(() {
                                return Text(
                                  controller
                                          .uploadVideoController.progress.value
                                          .toStringAsFixed(2) +
                                      "%",
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontFamily: "NexaBold",
                                    fontSize: 50,
                                  ),
                                );
                              })
                            ],
                          ),
                        )
                      : const SizedBox();
                })
              ],
            ),
          );
        });
  }
}
