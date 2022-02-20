import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/constant.dart';
import 'package:tiktok/controllers/profile_controller.dart';
import 'package:tiktok/views/widgets/background_loading.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(id),
        builder: (controller) {
          return controller.cargando
              ? const BackgroundLoading()
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black,
                    leading: const Icon(
                      Icons.person_add_alt_1_outlined,
                    ),
                    actions: [
                      Icon(
                        Icons.more_horiz,
                      )
                    ],
                    title: Text(
                      controller.user["name"],
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  body: SafeArea(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: controller.user["profilePhoto"],
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              placeholder: (c, url) => Padding(
                                padding: const EdgeInsets.all(8),
                                child: CircularProgressIndicator(
                                  color: buttonColor,
                                  strokeWidth: 15,
                                ),
                              ),
                              errorWidget: (c, url, error) => const Icon(
                                Icons.error,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                controller.user["following"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Follow",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.black54,
                            width: 1,
                            height: 15,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.user["followers"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Followers",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.black54,
                            width: 1,
                            height: 15,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.user["likes"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Likes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 140,
                        height: 47,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            if (id == authController.user.uid) {
                              controller.singOut();
                            } else {
                              controller.follorUser();
                            }
                          },
                          child: Center(
                            child: Text(
                              id == authController.user.uid
                                  ? "Sing Out"
                                  : controller.user["isFollowing"]
                                      ? "Unfollow"
                                      : "Follow",
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "NexaBold",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                            itemCount: controller.user["thumbnails"].length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              String thumbnail =
                                  controller.user["thumbnails"][index];
                              return CachedNetworkImage(
                                imageUrl: thumbnail,
                                fit: BoxFit.cover,
                                placeholder: (c, url) => Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CircularProgressIndicator(
                                    color: buttonColor,
                                    strokeWidth: 15,
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  )),
                );
        });
  }
}
