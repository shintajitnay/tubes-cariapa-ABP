import 'package:cariapa_project/pages/home/controller_home.dart';
import 'package:cariapa_project/pages/login/controller_login.dart';
import 'package:cariapa_project/pages/produk/controller_produk.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
