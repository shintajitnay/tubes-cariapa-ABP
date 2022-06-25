import 'package:cariapa_project/pages/home/controller_home.dart';
import 'package:cariapa_project/pages/produk/controller_produk.dart';
import 'package:get/get.dart';

class ProdukBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProdukController());
  }
}
