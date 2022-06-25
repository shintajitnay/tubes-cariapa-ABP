// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cariapa_project/config/config_color.dart';
import 'package:cariapa_project/config/config_image.dart';
import 'package:cariapa_project/config/config_setting.dart';
import 'package:cariapa_project/pages/home/controller_home.dart';
import 'package:cariapa_project/pages/produk/controller_produk.dart';
import 'package:cariapa_project/pages/splash/controller_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProdukPage extends StatelessWidget {
  final controller = Get.find<ProdukController>();

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
              layoutBottom(),
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
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Expanded(
                              child: Text(
                            "Informasi",
                            style: TextStyle(
                              color: AppColor.colortext,
                              fontSize: AppSetting.sizetextnormal + 2,
                              letterSpacing: AppSetting.sizeletterspacing,
                              fontWeight: FontWeight.w600,
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
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              layoutHeader(),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 25, left: 25, right: 25),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(controller.cHome.selectItem.tipe,
                                            style: TextStyle(
                                              letterSpacing:
                                                  AppSetting.sizeletterspacing,
                                              fontSize:
                                                  AppSetting.sizetextnormal,
                                              color: AppColor.colortext,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        Text(controller.cHome.selectItem.name,
                                            style: TextStyle(
                                              letterSpacing:
                                                  AppSetting.sizeletterspacing,
                                              fontSize:
                                                  AppSetting.sizetextnormal + 1,
                                              color: AppColor.colortext,
                                              fontWeight: FontWeight.w600,
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(top: 10)),
                                        Text(controller.cHome.selectItem.alamat,
                                            style: TextStyle(
                                              letterSpacing:
                                                  AppSetting.sizeletterspacing,
                                              fontSize:
                                                  AppSetting.sizetextnormal - 2,
                                              color: AppColor.colortext,
                                              fontWeight: FontWeight.w500,
                                            ))
                                      ],
                                    )),
                                    GetBuilder(
                                      init: controller.cHome,
                                      builder: (_) {
                                        return InkWell(
                                            onTap: () {
                                              controller.cHome.setBookmark(
                                                  controller
                                                      .cHome.selectItem.id);
                                            },
                                            child: SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: Image.asset(
                                                AppImage.bookmark,
                                                color: (controller.cHome
                                                        .selectItem.bookmark)
                                                    ? AppColor.colorgreenv3
                                                    : AppColor.colorgray,
                                              ),
                                            ));
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )))));
            }));
  }

  Widget layoutHeader() {
    return Container(
        height: 150,
        margin: EdgeInsets.only(top: 30),
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.cHome.selectItem.image.length,
            itemBuilder: (_, pos) {
              return Container(
                  width: 250,
                  margin: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: Image.network(
                        controller.cHome.selectItem.image[pos].trim(),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppImage.logo,
                            width: 20,
                            height: 20,
                          );
                        },
                      )));
            }));
  }

  Widget layoutBottom() {
    return Container(
      color: AppColor.colorgreenv3,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text("Harga",
                  style: TextStyle(
                    letterSpacing: AppSetting.sizeletterspacing,
                    fontSize: AppSetting.sizetextnormal + 2,
                    color: AppColor.colorwhite,
                    fontWeight: FontWeight.w500,
                  ))),
          Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text("Rp ",
                  style: TextStyle(
                    letterSpacing: AppSetting.sizeletterspacing,
                    fontSize: AppSetting.sizetextnormal + 2,
                    color: AppColor.colorwhite,
                    fontWeight: FontWeight.w500,
                  )),
              Text(controller.cHome.selectItem.harga,
                  style: TextStyle(
                    letterSpacing: AppSetting.sizeletterspacing,
                    fontSize: AppSetting.sizetextnormal + 6,
                    color: AppColor.colorwhite,
                    fontWeight: FontWeight.w500,
                  )),
              Text(" /malam",
                  style: TextStyle(
                    letterSpacing: AppSetting.sizeletterspacing,
                    fontSize: AppSetting.sizetextnormal - 3,
                    color: AppColor.colorwhite,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
