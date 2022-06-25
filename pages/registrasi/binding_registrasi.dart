import 'package:cariapa_project/pages/home/controller_home.dart';
import 'package:cariapa_project/pages/login/controller_login.dart';
import 'package:cariapa_project/pages/produk/controller_produk.dart';
import 'package:cariapa_project/pages/registrasi/controller_registrasi.dart';
import 'package:get/get.dart';

class RegistrasiBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RegistrasiController());
  }
}
