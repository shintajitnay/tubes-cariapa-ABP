// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cariapa_project/config/config_color.dart';
import 'package:cariapa_project/config/config_image.dart';
import 'package:cariapa_project/config/config_setting.dart';
import 'package:cariapa_project/pages/login/controller_login.dart';
import 'package:cariapa_project/pages/produk/controller_produk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: controller.closeAll,
          child: SafeArea(
              child: Column(
            children: <Widget>[
              layoutTop(),
              layoutBody(),
            ],
          ))),
    );
  }

  Widget layoutTop() {
    return AnimatedBuilder(
        animation: controller.animationController!,
        builder: (_, __) {
          return FadeTransition(
              opacity: controller.animationHeader!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - controller.animationHeader!.value), 0.0),
                  child: Container(
                      padding: EdgeInsets.only(left: 15, top: 23, right: 15),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                              onTap: controller.closeAll,
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: Image.asset(
                                  AppImage.back,
                                  color: AppColor.colorgray,
                                ),
                              )),
                        ],
                      ))));
        });
  }

  Widget layoutBody() {
    var animation = controller.getanimation(2);

    return Expanded(
        child: AnimatedBuilder(
            animation: controller.animationController!,
            builder: (_, __) {
              return FadeTransition(
                  opacity: animation,
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, 30 * (1.0 - animation.value), 0.0),
                      child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 25),
                          decoration: BoxDecoration(
                              color: AppColor.colorwhite,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: Offset(0, 3))
                              ]),
                          child: SingleChildScrollView(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 25, left: 25, right: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                          child: Image.asset(
                                        AppImage.logo,
                                        width: 150,
                                        height: 150,
                                      )),
                                      Text("Login",
                                          style: TextStyle(
                                            letterSpacing:
                                                AppSetting.sizeletterspacing,
                                            fontSize:
                                                AppSetting.sizetextnormal + 8,
                                            color: AppColor.colortext,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      Text(
                                          "Silahkan masukkan username dan password anda dengan benar",
                                          style: TextStyle(
                                            letterSpacing:
                                                AppSetting.sizeletterspacing,
                                            fontSize: AppSetting.sizetextnormal,
                                            color: AppColor.colortext,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(top: 30)),
                                      layoutInput(controller.inputusername,
                                          "Username", AppImage.userv2),
                                      Padding(
                                          padding: EdgeInsets.only(top: 20)),
                                      layoutInput(controller.inputpassword,
                                          "Password", AppImage.pass,
                                          pass: true),
                                      Padding(
                                          padding: EdgeInsets.only(top: 20)),
                                      layoutBottom(),
                                      Padding(
                                          padding: EdgeInsets.only(top: 30)),
                                      Container(
                                          width: double.infinity,
                                          child: Text("Belum punya akun ?",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                letterSpacing: AppSetting
                                                    .sizeletterspacing,
                                                fontSize:
                                                    AppSetting.sizetextnormal,
                                                color: AppColor.colortext,
                                                fontWeight: FontWeight.w500,
                                              ))),
                                      layoutRegistrasi(),
                                    ],
                                  ))))));
            }));
  }

  Widget layoutInput(inputcontroller, hinttext, image, {pass = false}) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
        decoration: BoxDecoration(
          color: AppColor.colorwhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColor.colorgray.withOpacity(0.7)),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                image,
                color: AppColor.colorgreenv3,
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Expanded(
                child: TextField(
              controller: inputcontroller,
              maxLines: 1,
              keyboardType: TextInputType.visiblePassword,
              obscureText: pass,
              inputFormatters: [LengthLimitingTextInputFormatter(60)],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                border: InputBorder.none,
                hintText: hinttext,
                isDense: true,
                focusedBorder: InputBorder.none,
                hintMaxLines: 1,
                hintStyle: TextStyle(
                    overflow: TextOverflow.fade,
                    letterSpacing: AppSetting.sizeletterspacing,
                    fontSize: AppSetting.sizetextnormal,
                    color: AppColor.colortext.withOpacity(0.7)),
              ),
              style: TextStyle(
                  letterSpacing: AppSetting.sizeletterspacing,
                  fontSize: AppSetting.sizetextnormal,
                  color: AppColor.colortext),
            )),
          ],
        ));
  }

  Widget layoutBottom() {
    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
            InkWell(
                onTap: () {
                  controller.validation();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  decoration: BoxDecoration(
                      color: AppColor.colorgreenv2,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: AppSetting.sizeletterspacing,
                        fontSize: AppSetting.sizetextnormal + 2,
                        color: AppColor.colorwhite,
                        fontWeight: FontWeight.w600,
                      )),
                )),
          ],
        ));
  }

  Widget layoutRegistrasi() {
    return Center(
        child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: <Widget>[
                InkWell(
                    onTap: () {
                      controller.moveactivity();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 12, bottom: 12, left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: AppColor.colorgreenv2,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text("Registrasi",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            letterSpacing: AppSetting.sizeletterspacing,
                            fontSize: AppSetting.sizetextnormal + 1,
                            color: AppColor.colorwhite,
                            fontWeight: FontWeight.w500,
                          )),
                    )),
              ],
            )));
  }
}
