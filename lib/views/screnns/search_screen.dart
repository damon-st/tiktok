import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/controllers/search_controller.dart';
import 'package:tiktok/models/user.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
        init: SearchController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red,
                title: TextFormField(
                  onFieldSubmitted: controller.onFieldSubmitted,
                  decoration: const InputDecoration(
                    filled: false,
                    hintText: "Search",
                    hintStyle: TextStyle(),
                  ),
                ),
              ),
              body: Obx(() {
                return controller.searchUsers.isEmpty
                    ? Center(
                        child: Text(
                          "Search for usrers!",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.searchUsers.length,
                        itemBuilder: (context, index) {
                          User user = controller.searchUsers[index];
                          return ListTile(
                            onTap: () {
                              controller.profileUser(user.uuid);
                            },
                            title: Text(
                              user.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "NexaBold",
                                fontSize: 18,
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.profilePhoto),
                            ),
                          );
                        });
              }));
        });
  }
}
