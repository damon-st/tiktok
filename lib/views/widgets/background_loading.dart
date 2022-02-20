import 'package:flutter/material.dart';
import 'package:tiktok/constant.dart';

class BackgroundLoading extends StatelessWidget {
  const BackgroundLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: backgroundColor,
      child: Center(
        child: CircularProgressIndicator(
          color: buttonColor,
          strokeWidth: 15,
        ),
      ),
    );
  }
}
