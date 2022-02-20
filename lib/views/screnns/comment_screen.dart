import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/constant.dart';
import 'package:tiktok/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommetScreen extends StatelessWidget {
  const CommetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(
        init: CommentController(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                width: Get.width,
                height: Get.height,
                child: Column(
                  children: [
                    Expanded(child: Obx(() {
                      return ListView.builder(
                        itemCount: controller.comments.length,
                        itemBuilder: (context, index) {
                          final comment = controller.comments[index];
                          return ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    comment.username,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontFamily: "NexaBold",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      comment.comment,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "NexaBold",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    timeago.format(
                                        comment.datePublished.toDate(),
                                        locale: "es"),
                                    style: TextStyle(
                                      fontFamily: "NexaBold",
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${comment.likes.length} liks",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "NexaBold",
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.black,
                                backgroundImage:
                                    NetworkImage(comment.profilePhoto),
                              ),
                              trailing: InkWell(
                                onTap: () {
                                  controller.likeComment(comment.id);
                                },
                                child: Icon(
                                  Icons.favorite,
                                  size: 25,
                                  color: comment.likes
                                          .contains(authController.user.uid)
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ));
                        },
                      );
                    })),
                    const Divider(),
                    ListTile(
                      title: TextFormField(
                        controller: controller.textController,
                        style: const TextStyle(
                            fontFamily: "NexaBold",
                            fontSize: 16,
                            color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: "Comment",
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      trailing: TextButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          controller
                              .postCommnet(controller.textController.text);
                        },
                        child: Text(
                          "Send",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "NexaBold",
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
