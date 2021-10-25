import 'package:get/get.dart';

import '../controllers/statistique_controller.dart';

class StatistiqueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatistiqueController>(
      () => StatistiqueController(),
    );
  }
}
