// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:cariapa_project/config/config_route.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController? animationController;
  Animation<double>? animationHeader;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    animationHeader = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Interval(0, 1, curve: Curves.fastOutSlowIn)));

    validation();
  }

  @override
  void onReady() {
    super.onReady();
    animationController!.forward();
  }

  void validation() async {
    await Future.delayed(Duration(seconds: 3));
    Get.delete<SplashController>();
    Get.offAllNamed(AppRoute.home);
  }
}
