// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:cariapa_project/config/config_color.dart';
import 'package:cariapa_project/config/config_route.dart';
import 'package:cariapa_project/config/config_setting.dart';
import 'package:cariapa_project/pages/home/controller_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  AnimationController? animationController;
  Animation<double>? animationHeader;

  TextEditingController inputusername = TextEditingController();
  TextEditingController inputpassword = TextEditingController();

  String username = "";
  String password = "";

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

  Future<bool> closeAll() async {
    await animationController?.reverse();
    animationController?.dispose();

    Get.delete<LoginController>();
    Get.back();

    return false;
  }

  Animation<double> getanimation(pos) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0.1 * pos, 1, curve: Curves.fastOutSlowIn)));
  }

  void moveactivity() {
    Get.toNamed(AppRoute.registrasi);
  }

  void validation() {
    username = inputusername.text.toString().trim();
    password = inputpassword.text.toString().trim();

    var error = "";
    if (username.isEmpty) {
      error = "Username tidak boleh kosong";
    } else if (password.isEmpty) {
      error = "Password tidak boleh kosong";
    }

    if (error.isNotEmpty) {
      showToast(error);
    } else {
      checkData();
    }
  }

  void showToast(message, {done = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: (done) ? AppColor.colorgreenv2 : AppColor.colorred,
      textColor: AppColor.colorwhite,
      fontSize: AppSetting.sizetextnormal,
    );
  }

  void checkData() async {
    var db = await openDatabase(AppSetting.dbname);
    List<Map> listuser = await db.query(AppSetting.tableuser,
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);

    if (listuser.length > 0) {
      saveData(listuser[0]['name']);
      cHome.getLogin();
      showToast("Login Berhasil", done: true);
      closeAll();
    } else {
      showToast("Username dan password tidak ditemukan, coba kembali");
    }
    db.close();
  }

  void saveData(name) {
    final prefs = GetStorage();
    prefs.write('name', name);
  }
}
