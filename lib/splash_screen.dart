import 'package:app_calander/calender_screen.dart';
import 'package:app_calander/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const AppCalender();
        },
      ));
    });

    return Scaffold(
      body: Image.asset(
        AppImages.splash,
        height: Get.height,
        width: Get.width,
        fit: BoxFit.fill,
      ),
    );
  }
}
