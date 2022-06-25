// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cariapa_project/config/config_color.dart';
import 'package:cariapa_project/config/config_image.dart';
import 'package:cariapa_project/config/config_setting.dart';
import 'package:cariapa_project/pages/home/controller_home.dart';
import 'package:cariapa_project/pages/home/model_home.dart';
import 'package:cariapa_project/pages/splash/controller_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async => true,
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
                      child: GetBuilder(
                        init: controller,
                        builder: (_) {
                          return Row(
                            children: <Widget>[
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: Image.asset(AppImage.user),
                              ),
                              Padding(padding: EdgeInsets.only(left: 8)),
                              Expanded(
                                  child: Text(
                                (controller.login)
                                    ? controller.name
                                    : "Selamat Datang",
                                style: TextStyle(
                                  color: AppColor.colortext,
                                  fontSize: AppSetting.sizetextnormal + 2,
                                  letterSpacing: AppSetting.sizeletterspacing,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                              InkWell(
                                  onTap: () {
                                    controller.buttonlogin();
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    decoration: BoxDecoration(
                                        color: AppColor.colorgreenv2,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          (controller.login)
                                              ? "Logout"
                                              : "Login",
                                          style: TextStyle(
                                            color: AppColor.colorwhite,
                                            fontSize: AppSetting.sizetextnormal,
                                            letterSpacing:
                                                AppSetting.sizeletterspacing,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 7)),
                                        Image.asset(
                                          (controller.login)
                                              ? AppImage.logout
                                              : AppImage.login,
                                          height: 18,
                                          color: AppColor.colorwhite,
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          );
                        },
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
                          margin: EdgeInsets.only(top: 30),
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
                            children: <Widget>[
                              layoutSearch(),
                              layoutList(),
                            ],
                          )))));
            }));
  }

  Widget layoutSearch() {
    return Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 30),
        child: GetBuilder(
          init: controller,
          builder: (_) {
            return Column(
              children: <Widget>[
                Container(
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
                    decoration: BoxDecoration(
                      color: AppColor.colorwhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColor.colorgray.withOpacity(0.7)),
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            AppImage.location,
                            color: AppColor.colorgreenv3,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Expanded(
                            child: TextField(
                          controller: controller.inputlocation,
                          maxLines: 1,
                          keyboardType: TextInputType.visiblePassword,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(60)
                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                            border: InputBorder.none,
                            hintText: "Lokasi",
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
                    )),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
                    decoration: BoxDecoration(
                      color: AppColor.colorwhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColor.colorgray.withOpacity(0.7)),
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            AppImage.datetime,
                            color: AppColor.colorgreenv3,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Expanded(
                            child: InkWell(
                                onTap: () {
                                  controller.setDateTime();
                                },
                                child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      controller.textdate,
                                      style: TextStyle(
                                        letterSpacing:
                                            AppSetting.sizeletterspacing,
                                        fontSize: AppSetting.sizetextnormal,
                                        color: AppColor.colortext,
                                      ),
                                    )))),
                        InkWell(
                            onTap: () {
                              Get.bottomSheet(bottomSheet());
                            },
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: Image.asset(
                                    AppImage.room,
                                    color: AppColor.colorgreenv3,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 2)),
                                Text(
                                  controller.room.toString(),
                                  style: TextStyle(
                                    letterSpacing: AppSetting.sizeletterspacing,
                                    fontSize: AppSetting.sizetextnormal,
                                    color: AppColor.colortext,
                                  ),
                                )
                              ],
                            )),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        InkWell(
                            onTap: () {
                              Get.bottomSheet(bottomSheet());
                            },
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: Image.asset(
                                    AppImage.guest,
                                    color: AppColor.colorgreenv3,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 2)),
                                Text(
                                  controller.guest.toString(),
                                  style: TextStyle(
                                    letterSpacing: AppSetting.sizeletterspacing,
                                    fontSize: AppSetting.sizetextnormal,
                                    color: AppColor.colortext,
                                  ),
                                )
                              ],
                            ))
                      ],
                    )),
                layoutBottom()
              ],
            );
          },
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
                  child: Text("Cari",
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

  Widget layoutList() {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return ListView.builder(
            padding: EdgeInsets.only(left: 30, right: 30, top: 20),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.dataitem.length,
            itemBuilder: (_, pos) {
              return itemList(controller.dataitem[pos]);
            });
      },
    );
  }

  Widget itemList(ProdukModel dataitem) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: InkWell(
            onTap: () {
              controller.movetoProduk(dataitem);
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColor.colorwhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.colorgray.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                      color: AppColor.colorgrayv3.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3))
                ],
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(dataitem.name,
                              style: TextStyle(
                                letterSpacing: AppSetting.sizeletterspacing,
                                fontSize: AppSetting.sizetextnormal + 1,
                                color: AppColor.colortext,
                                fontWeight: FontWeight.w600,
                              ))),
                      Text(dataitem.tipe,
                          style: TextStyle(
                            letterSpacing: AppSetting.sizeletterspacing,
                            fontSize: AppSetting.sizetextnormal,
                            color: AppColor.colortext,
                            fontWeight: FontWeight.w500,
                          ))
                    ],
                  ),
                  Container(
                      height: 100,
                      margin: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: dataitem.image.length,
                          itemBuilder: (_, pos2) {
                            return Container(
                                width: 150,
                                margin: EdgeInsets.only(right: 4),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(3),
                                    child: Image.network(
                                      dataitem.image[pos2].trim(),
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          AppImage.logo,
                                          width: 20,
                                          height: 20,
                                        );
                                      },
                                    )));
                          })),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(dataitem.alamat,
                                  style: TextStyle(
                                    letterSpacing: AppSetting.sizeletterspacing,
                                    fontSize: AppSetting.sizetextnormal - 2,
                                    color: AppColor.colortext,
                                    fontWeight: FontWeight.w500,
                                  ))),
                          InkWell(
                              onTap: () {
                                controller.setBookmark(dataitem.id);
                              },
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: Image.asset(
                                  AppImage.bookmark,
                                  color: (dataitem.bookmark)
                                      ? AppColor.colorgreenv3
                                      : AppColor.colorgray,
                                ),
                              )),
                        ],
                      ))
                ],
              ),
            )));
  }

  Widget bottomSheet() {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Container(
            color: AppColor.colorwhite,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text("Kamar",
                            style: TextStyle(
                              letterSpacing: AppSetting.sizeletterspacing,
                              fontSize: AppSetting.sizetextnormal + 2,
                              color: AppColor.colortext,
                              fontWeight: FontWeight.w500,
                            ))),
                    InkWell(
                        onTap: () {
                          controller.addRoom();
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: AppColor.colorwhite,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.colorgray)),
                          child: ClipOval(
                            child: Icon(
                              Icons.add,
                              size: 20,
                            ),
                          ),
                        )),
                    Container(
                        width: 50,
                        child: Text(controller.room.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              letterSpacing: AppSetting.sizeletterspacing,
                              fontSize: AppSetting.sizetextnormal + 2,
                              color: AppColor.colortext,
                              fontWeight: FontWeight.w600,
                            ))),
                    InkWell(
                        onTap: () {
                          controller.substractRoom();
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: AppColor.colorwhite,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.colorgray)),
                          child: ClipOval(
                            child: Icon(
                              Icons.remove,
                              size: 20,
                            ),
                          ),
                        )),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text("Tamu",
                            style: TextStyle(
                              letterSpacing: AppSetting.sizeletterspacing,
                              fontSize: AppSetting.sizetextnormal + 2,
                              color: AppColor.colortext,
                              fontWeight: FontWeight.w500,
                            ))),
                    InkWell(
                        onTap: () {
                          controller.addGuest();
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: AppColor.colorwhite,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.colorgray)),
                          child: ClipOval(
                            child: Icon(
                              Icons.add,
                              size: 20,
                            ),
                          ),
                        )),
                    Container(
                        width: 50,
                        child: Text(controller.guest.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              letterSpacing: AppSetting.sizeletterspacing,
                              fontSize: AppSetting.sizetextnormal + 2,
                              color: AppColor.colortext,
                              fontWeight: FontWeight.w600,
                            ))),
                    InkWell(
                        onTap: () {
                          controller.substractGuest();
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: AppColor.colorwhite,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.colorgray)),
                          child: ClipOval(
                            child: Icon(
                              Icons.remove,
                              size: 20,
                            ),
                          ),
                        )),
                  ],
                )
              ],
            ));
      },
    );
  }
}
