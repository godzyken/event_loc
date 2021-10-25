import 'package:get/get.dart';

import '../controllers/add_publicity_controller.dart';

class AddPublicityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPublicityController>(
      () => AddPublicityController(),
    );
  }
}
