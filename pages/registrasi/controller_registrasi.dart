// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:cariapa_project/config/config_color.dart';
import 'package:cariapa_project/config/config_setting.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrasiController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController? animationController;
  Animation<double>? animationHeader;

  TextEditingController inputname = TextEditingController();
  TextEditingController inputusername = TextEditingController();
  TextEditingController inputpassword = TextEditingController();

  String name = "";
  String username = "";
  String password = "";

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

  void validation() {
    name = inputname.text.toString().trim();
    username = inputusername.text.toString().trim();
    password = inputpassword.text.toString().trim();

    var error = "";
    if (name.isEmpty) {
      error = "Nama tidak boleh kosong";
    } else if (username.isEmpty) {
      error = "Username tidak boleh kosong";
    } else if (password.isEmpty) {
      error = "Password tidak boleh kosong";
    }

    if (error.isNotEmpty) {
      showToast(error);
    } else {
      saveData();
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

  void saveData() async {
    var db = await openDatabase(AppSetting.dbname);
    List<Map> listuser = await db.query(AppSetting.tableuser,
        where: 'username = ?', whereArgs: [username]);

    if (listuser.length > 0) {
      showToast("Username sudah pernah digunakan, coba kembali");
    } else {
      var data = {
        'name': name,
        'username': username,
        'password': password,
      };

      try {
        var batch = db.batch();
        batch.insert(AppSetting.tableuser, data);
        await batch.commit();
      } catch (e) {
        print(e);
      }

      showToast("Pendaftaran Berhasil", done: true);
      closeAll();
    }
    db.close();
  }

  Future<bool> closeAll() async {
    await animationController?.reverse();
    animationController?.dispose();

    Get.delete<RegistrasiController>();
    Get.back();

    return false;
  }
}
