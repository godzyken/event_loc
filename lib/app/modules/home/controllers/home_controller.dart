import 'dart:ffi';

import 'package:event_loc/app/modules/login/controllers/login_controller.dart';
import 'package:event_loc/app/modules/profil/controllers/profil_controller.dart';
import 'package:event_loc/user.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final MethodChannel? platform = MethodChannel('godzy.flutter.dev/home');
  String? _homeLevel = 'unknown home state';

  final auth = GetxFire.auth;
  final loginC = LoginController();
  final profileC = ProfilController();
  User? get user => auth.currentUser;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _getHomeState();
  }

  @override
  void onReady() {
    super.onReady();
    _getHomeState();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<String> _getHomeState() async {
    String? homeLevel;

    try {
      final result = await platform!.invokeMethod('MyUserModelApi');
      homeLevel = 'Home state $result % .';
    } on PlatformException catch (e) {
      homeLevel = "Failed to get home : '${e.message}'.";
    }

    return _homeLevel = homeLevel;

  }
}
