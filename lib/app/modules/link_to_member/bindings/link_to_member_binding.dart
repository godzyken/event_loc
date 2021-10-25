import 'package:get/get.dart';

import '../controllers/link_to_member_controller.dart';

class LinkToMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LinkToMemberController>(
      () => LinkToMemberController(),
    );
  }
}
