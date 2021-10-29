import 'package:event_loc/app/data/database/usd_db.dart';
import 'package:event_loc/app/modules/home/views/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class LoginController extends GetxController {
  final phone = TextEditingController().obs;
  final email = TextEditingController().obs;
  final password = TextEditingController().obs;
  final formKey = GlobalKey<FormState>();
  final screenWidth = Get.mediaQuery.size.width;
  final double r = (175 / 360); //  rapport for web test(304 / 540);
  double get coverHeight => screenWidth * r;
  var pinned = false.obs;
  var snap = false.obs;
  var floating = false.obs;
  var emailFormVisible = false.obs;
  var telFormVisible = false.obs;

  var isLoading = false.obs;
  var verId = '';
  var authStatus = ''.obs;

  var auth = GetxFire.auth;
  var db = UserDb();

  final count = 0.obs;

  @override
  void onInit() {
    update();
    super.onInit();
  }

  @override
  void onReady() {
    update();
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  void checkLogin() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      formKey.currentState!.save();
    }
  }

  String? verifyEmail(String? value) {
    if (!GetUtils.isEmail(value!)) {
      return "Provide valid Email";
    } else {
      return "email ok!";
    }
  }

  String? verifyPassword(String? value) {
    if (!GetUtils.isLengthGreaterOrEqual(value!, 8)) {
      return "Password is too shor";
    } else {
      return "password length ok!";
    }
  }

  emailFormVisibility() {
    emailFormVisible.toggle();
    update();
  }

  phoneFormVisibility() {
    telFormVisible.toggle();
    update();
  }

  loginWithEmailPassword(String? email, String? password) async {
    await GetxFire.signInWithEmailAndPassword(
      email: email!,
      password: password!,
      isSuccessDialog: true,
      isErrorDialog: true,
      onSuccess: (userCredential) => db.db.streamData(
        collection: db.collection,
        idChild: userCredential?.user!.uid,
        collectionChild: userCredential?.user!.email,
        isErrorDialog: true,
        onError: (error) => GetxFire.openDialog.messageError(
          error!,
          title: "Error data user not found on cloud firestore",
          duration: const Duration(seconds: 12),
        ),
      ),
      onError: (code, message) {
        print('yoooo: $code, $message');

        if (code == 'user-not-found') {
          GetxFire.openDialog.messageError(
            message!,
            title: code,
            duration: const Duration(seconds: 12),
          );
          Get.back();
        }

        if (code == 'unknown') {
          GetxFire.openDialog.messageError(
            message!,
            title: code,
            duration: const Duration(seconds: 12),
          );
          Get.back();
        }

        if (code == 'invalid-email') {
          GetxFire.openDialog.messageError(
            message!,
            title: code,
            duration: const Duration(seconds: 12),
          );
          Get.back();
        }

        if (code == 'wrong-password') {
          GetxFire.openDialog.messageError(
            message!,
            title: code,
            duration: const Duration(seconds: 12),
          );
          Get.back();
        }

        if (code == 'operation-not-allowed') {
          GetxFire.openDialog.messageError(
            message!,
            title: code,
            duration: const Duration(seconds: 12),
          );
          Get.back();
        }

        if (code == 'weak-password') {
          GetxFire.openDialog.messageError(
            message!,
            title: code,
            duration: const Duration(seconds: 12),
          );
          Get.back();
        }
      }
    );
  }

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
              duration: const Duration(seconds: 12));
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
          PhoneAuthProvider.credential(verificationId: verId, smsCode: otp!));
      if (userCredential.user != null) {
        isLoading.value = false;
        await db.addNewUser(userCredential.user!.phoneNumber);
        Get.to(() => HomeView());
      }
    } on FirebaseAuthException catch (code, e) {
      print('opt problem: ${e.toString()}');
      GetxFire.openDialog.messageError("otp info: ${code.message}",
          title: "otp code is not correct !!: ${code.code}",
          duration: const Duration(seconds: 12));
    }
  }
}
