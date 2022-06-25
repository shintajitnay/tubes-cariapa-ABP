// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:cariapa_project/config/config_setting.dart';
import 'package:cariapa_project/pages/home/controller_home.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class ProdukController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController? animationController;
  Animation<double>? animationHeader;

  var cHome = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
        duration: Duration(milliseconds: AppSetting.timeanimation),
        vsync: this);

    animationHeader = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
  }

  @override
  void onReady() {
    super.onReady();
    animationController!.forward();
  }

  Animation<double> getanimation(pos) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0.1 * pos, 1, curve: Curves.fastOutSlowIn)));
  }

  Future<bool> closeAll() async {
    await animationController?.reverse();
    animationController?.dispose();

    Get.delete<ProdukController>();
    Get.back();

    return false;
  }
}
