import 'package:get/get.dart';

import '../controllers/publicity_controller.dart';

class PublicityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublicityController>(
      () => PublicityController(),
    );
  }
}
