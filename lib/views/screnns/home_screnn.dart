import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/constant.dart';
import 'package:tiktok/controllers/home_controller.dart';
import 'package:tiktok/views/widgets/custom_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: "home",
        init: HomeController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: controller.onWillPop,
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                  onTap: controller.selectedIndex,
                  backgroundColor: backgroundColor,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: controller.index,
                  selectedItemColor: Colors.red,
                  unselectedItemColor: Colors.white,
                  items: [
                    BottomNavigationBarItem(
                      label: "Home",
                      icon: Icon(
                        Icons.home,
                        size: 30,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "Search",
                      icon: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "",
                      icon: CustomIcon(),
                    ),
                    BottomNavigationBarItem(
                      label: "Message",
                      icon: Icon(
                        Icons.message,
                        size: 30,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "Profile",
                      icon: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                  ]),
              body: pages[controller.index],
            ),
          );
        });
  }
}
