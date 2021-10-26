import 'package:event_loc/app/data/database/usd_db.dart';
import 'package:event_loc/app/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfilController extends GetxController {
  final _userModel = UserModel().obs;

  UserModel? get user => _userModel.value;
  set user(UserModel? value) => _userModel.value = value!;

  final count = 0.obs;
  final firstname = TextEditingController().obs;
  final lastname = TextEditingController().obs;
  final email = TextEditingController().obs;
  final phone = TextEditingController().obs;
  final avatar = TextEditingController().obs;
  final location = TextEditingController().obs;
  final type = TextEditingController().obs;
  final state = TextEditingController().obs;
  final double coverHeight = 280;
  final double profileHeight = 144;

  var db = UserDb();

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

  void clear() {
    _userModel.value = UserModel();
  }

  updateUser(firstname, lastname, email, phone, avatar, location, type, state) {
    db.editProfile(
        firstname, lastname, email, phone, avatar, location, type, state);
  }

  getUser() async {
    return await db.showUser();
  }
}
