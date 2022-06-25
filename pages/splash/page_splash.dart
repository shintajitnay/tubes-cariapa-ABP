// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cariapa_project/config/config_image.dart';
import 'package:cariapa_project/pages/splash/controller_splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  final controller = Get.find<SplashController>();

  SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: AnimatedBuilder(
                animation: controller.animationController!,
                builder: (_, __) {
                  return FadeTransition(
                    opacity: controller.animationHeader!,
                    child: Transform(
                        transform: Matrix4.translationValues(
                            0.0,
                            30 * (1.0 - controller.animationHeader!.value),
                            0.0),
                        child: Center(
                            child: SizedBox(
                                width: 250,
                                height: 250,
                                child: Image.asset(
                                  AppImage.logo,
                                )))),
                  );
                })));
  }
}
