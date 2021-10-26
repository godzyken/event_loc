import 'package:event_loc/app/modules/profil/controllers/profil_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<ProfilController>(
          () => ProfilController(),
    );
  }
}
