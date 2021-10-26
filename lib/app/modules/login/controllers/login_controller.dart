import 'package:event_loc/app/data/database/usd_db.dart';
import 'package:event_loc/app/modules/home/views/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final phone = TextEditingController().obs;
  var isLoading = false.obs;
  var verId = '';
  var authStatus = ''.obs;

  var auth = GetxFire.auth;
  var db = UserDb();

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

  verifyPhone(String? phone) async {
    isLoading.value = true;
    await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 50),
        phoneNumber: phone!,
        verificationCompleted: (PhoneAuthCredential authCredential) {
          print("verification completed ${authCredential.smsCode}");
          if (auth.currentUser != null) {
            isLoading.value = false;
            authStatus.value = "login successfully";
          }
        },
        verificationFailed: (authException) {
          GetxFire.openDialog.messageError(
              "sms code info: ${authException.message}",
              title: "otp code hasn't been sent!!",
              duration: const Duration(seconds: 12)
          );
        },
        codeSent: (String? id, [int? forceResent]) {
          isLoading.value = false;
          verId = id!;
          authStatus.value = "login successfully";
        },
        codeAutoRetrievalTimeout: (String? id) {
          verId = id!;
        });
  }

  otpVerify(String? otp) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(verificationId: verId, smsCode: otp!)
      );
      if (userCredential.user != null) {
        isLoading.value = false;
        await db.addNewUser(userCredential.user!.phoneNumber);
        Get.to(() => HomeView());
      }
    } on FirebaseAuthException catch (code, e) {
      print('opt problem: ${e.toString()}');
      GetxFire.openDialog.messageError(
          "otp info: ${code.message}",
          title: "otp code is not correct !!: ${code.code}",
        duration: const Duration(seconds: 12)
      );
    }
  }
}
