import 'package:get/get.dart';

import '../controllers/administration_controller.dart';

class AdministrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdministrationController>(
      () => AdministrationController(),
    );
  }
}
