import 'package:cariapa_project/config/config_color.dart';
import 'package:cariapa_project/config/config_fonts.dart';
import 'package:cariapa_project/config/config_route.dart';
import 'package:cariapa_project/config/config_setting.dart';
import 'package:cariapa_project/pages/home/binding_home.dart';
import 'package:cariapa_project/pages/home/page_home.dart';
import 'package:cariapa_project/pages/login/binding_login.dart';
import 'package:cariapa_project/pages/login/page_login.dart';
import 'package:cariapa_project/pages/produk/binding_produk.dart';
import 'package:cariapa_project/pages/produk/page_produk.dart';
import 'package:cariapa_project/pages/registrasi/binding_registrasi.dart';
import 'package:cariapa_project/pages/registrasi/page_registrasi.dart';
import 'package:cariapa_project/pages/splash/binding_splash.dart';
import 'package:cariapa_project/pages/splash/page_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColor.colorgreenv3));
  await GetStorage.init();
  settingSqlite();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: AppFont.fontnormal,
        ),
        initialRoute: AppRoute.splashcreen,
        getPages: [
          GetPage(
            name: AppRoute.splashcreen,
            page: () => SplashPage(),
            binding: SplashBinding(),
          ),
          GetPage(
            name: AppRoute.home,
            page: () => HomePage(),
            binding: HomeBinding(),
          ),
          GetPage(
            name: AppRoute.produk,
            page: () => ProdukPage(),
            binding: ProdukBinding(),
          ),
          GetPage(
            name: AppRoute.login,
            page: () => LoginPage(),
            binding: LoginBinding(),
          ),
          GetPage(
            name: AppRoute.registrasi,
            page: () => RegistrasiPage(),
            binding: RegistrasiBinding(),
          ),
        ]);
  }
}

void settingSqlite() async {
  try {
    openDatabase(
      join(await getDatabasesPath(), AppSetting.dbname),
      onUpgrade: (db, oldVersion, newVersion) async {
        if (newVersion != oldVersion) {
          var batch = db.batch();
          batch.execute(AppSetting.query_delete_table_user);
          batch.execute(AppSetting.query_delete_table_hotel);

          await batch.commit();
        }
      },
      onCreate: (db, version) async {
        db.execute(AppSetting.query_create_table_user);
        await db.execute(AppSetting.query_create_table_hotel);
        for (var item in AppSetting.listhotel) {
          db.execute(item);
        }
      },
      version: AppSetting.dbversion,
    );
  } catch (e) {
    Future.delayed(Duration(seconds: 2)).then((_) {
      print("ERROR CREATE DB");
    });
  }
}
