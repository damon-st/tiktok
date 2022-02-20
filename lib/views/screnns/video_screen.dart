import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/constant.dart';
import 'package:tiktok/controllers/video_controller.dart';
import 'package:tiktok/models/video.dart';
import 'package:tiktok/views/widgets/circle_animation.dart';
import 'package:tiktok/views/widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(
        id: "video",
        init: VideoController(),
        builder: (controller) {
          return Scaffold(
            body: Obx(() {
              return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: controller.videoList.length,
                  controller:
                      PageController(initialPage: 0, viewportFraction: 1),
                  itemBuilder: (context, index) {
                    Video video = controller.videoList[index];
                    return Stack(
                      children: [
                        VideoPlayerItem(
                          videoUrl: video.videoUrl,
                          thumblain: video.thumbnail,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            video.username,
                                            style: TextStyle(
                                                fontFamily: "NexaBold",
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            video.caption,
                                            style: TextStyle(
                                              fontFamily: "NexaBold",
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.music_note,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                video.songname,
                                                style: TextStyle(
                                                    fontFamily: "NexaBold",
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin:
                                        EdgeInsets.only(top: Get.height / 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        builProfile(video.profilePhoto),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.likeVideo(video.id);
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                size: 40,
                                                color: video.likes.contains(
                                                        authController.user.uid)
                                                    ? Colors.red
                                                    : Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Text(
                                              video.likes.length.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "NexaBold",
                                                fontSize: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.comentVide(video.id);
                                              },
                                              child: const Icon(
                                                Icons.comment,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Text(
                                              video.commentCount.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "NexaBold",
                                                fontSize: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: const Icon(
                                                Icons.reply,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Text(
                                              video.shareCount.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "NexaBold",
                                                fontSize: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                        CircleAnimation(
                                          child: buildMusicAlbum(
                                            video.profilePhoto,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  });
            }),
          );
        });
  }

  SizedBox buildMusicAlbum(String profile) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                gradient:
                    const LinearGradient(colors: [Colors.grey, Colors.white]),
                borderRadius: BorderRadius.circular(25)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                25,
              ),
              child: Image(
                image: NetworkImage(profile),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox builProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
