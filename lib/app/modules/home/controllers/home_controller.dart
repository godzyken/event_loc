import 'package:event_loc/app/modules/login/controllers/login_controller.dart';
import 'package:event_loc/app/modules/profil/controllers/profil_controller.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final auth = GetxFire.auth;
  final loginC = LoginController();
  final profileC = ProfilController();
  User? get user => auth.currentUser;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
