import 'package:event_loc/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';

import '../controllers/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(
      () => OtpController(),
    );

    Get.lazyPut<LoginController>(
          () => LoginController(),
    );
  }
}
