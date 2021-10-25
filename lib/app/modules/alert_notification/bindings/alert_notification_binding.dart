import 'package:get/get.dart';

import '../controllers/alert_notification_controller.dart';

class AlertNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlertNotificationController>(
      () => AlertNotificationController(),
    );
  }
}
