import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> showCustomDialog(String title, String msg,
    {Color bg = Colors.black,
    Color colorText = Colors.white,
    String textConfirm = "Confirm",
    String textCancel = "Cancel"}) async {
  return await Get.dialog(
        SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(
            title,
            style: TextStyle(
              color: colorText,
              fontFamily: "NexaBold",
              fontSize: 18,
            ),
          ),
          insetPadding: const EdgeInsets.all(8),
          titlePadding: const EdgeInsets.all(8),
          children: [
            Row(
              children: [
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: Text(
                      textCancel,
                      style: const TextStyle(
                          color: Colors.red,
                          fontFamily: "NexaBold",
                          fontSize: 18),
                    ),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      Get.back(result: true);
                    },
                    child: Text(
                      textConfirm,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "NexaBold",
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ) ??
      false;
}
