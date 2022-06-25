// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'dart:convert';

import 'package:cariapa_project/config/config_color.dart';
import 'package:cariapa_project/config/config_route.dart';
import 'package:cariapa_project/config/config_setting.dart';
import 'package:cariapa_project/pages/home/model_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  AnimationController? animationController;
  Animation<double>? animationHeader;

  TextEditingController inputlocation = TextEditingController();

  bool login = false;
  String name = "";

  final formatdate = DateFormat('dd MMM');
  String textdate = "";
  String textlocation = "";
  int room = 1;
  int guest = 1;

  DateTimeRange initialDate = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(days: 1)));

  List<ProdukModel> dataitem = [];
  ProdukModel selectItem = ProdukModel(image: []);

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

    textdate = formatdate.format(initialDate.start) +
        " - " +
        formatdate.format(initialDate.end);

    getLogin();
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

  void movetoProduk(ProdukModel dataitem) {
    Get.focusScope?.unfocus();
    selectItem = dataitem;
    Get.toNamed(AppRoute.produk);
  }

  void buttonlogin() {
    if (login) {
      Get.defaultDialog(
          title: "Logout",
          middleText: "Anda yakin akan keluar ?",
          textConfirm: "Ya",
          textCancel: "Kembali",
          cancelTextColor: AppColor.colortext,
          confirmTextColor: AppColor.colorwhite,
          buttonColor: AppColor.colorgreenv3,
          onConfirm: clear);
    } else {
      Get.toNamed(AppRoute.login);
    }
  }

  void getLogin() {
    final prefs = GetStorage();
    var textname = prefs.read('name');
    if (textname != null) {
      login = true;
      name = textname;

      refresh();
    }
  }

  void clear() {
    final prefs = GetStorage();
    prefs.remove("name");
    Get.offNamedUntil(AppRoute.splashcreen, (route) => false);
  }

  void setDateTime() async {
    DateTimeRange? picked = await showDateRangePicker(
      initialDateRange: initialDate,
      context: Get.context!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (picked != null) {
      textdate = formatdate.format(picked.start) +
          " - " +
          formatdate.format(picked.end);
      refresh();
    }
  }

  void addRoom() {
    if (room < 8) {
      room += 1;
      refresh();
    }
  }

  void addGuest() {
    if (guest < 8) {
      guest += 1;
      refresh();
    }
  }

  void substractRoom() {
    if (room > 1) {
      room -= 1;
      refresh();
    }
  }

  void substractGuest() {
    if (guest > 1) {
      guest -= 1;
      refresh();
    }
  }

  void validation() async {
    Get.focusScope?.unfocus();
    dataitem.clear();
    refresh();
    await Future.delayed(Duration(milliseconds: 300));
    textlocation = inputlocation.text.trim();

    if (textlocation.isNotEmpty) {
      checkData();
    }
  }

  void checkData() async {
    var db = await openDatabase(AppSetting.dbname);
    List<Map> listitem = await db.rawQuery(
        "SELECT * FROM ${AppSetting.tablehotel} where alamat LIKE '%${textlocation}%'");

    if (listitem.length > 0) {
      for (var item in listitem) {
        var image = item['image'].split(",");

        dataitem.add(ProdukModel(
            id: item['id'],
            name: item['name'],
            tipe: item['tipe'],
            alamat: item['alamat'],
            harga: item['harga'],
            bookmark: item['bookmark'] == "0" ? false : true,
            image: image));
      }

      refresh();
    }

    db.close();
  }

  void setBookmark(id) async {
    var pos = dataitem.indexWhere((item) => item.id == id);
    if (pos >= 0) {
      var bookmark = (dataitem[pos].bookmark) ? false : true;
      dataitem[pos].bookmark = bookmark;

      var value = (bookmark) ? "1" : "0";

      try {
        var db = await openDatabase(AppSetting.dbname);
        await db.rawQuery(
            "UPDATE ${AppSetting.tablehotel} SET bookmark = '${value}' WHERE id = '${id}'");
        db.close();
      } catch (e) {
        print("ERROR ${e}");
      }

      refresh();
    }
  }
}
