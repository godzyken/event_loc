import 'package:event_loc/app/data/database/usd_db.dart';
import 'package:event_loc/app/data/models/user_model.dart';
import 'package:event_loc/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class SignInController extends GetxController {
  final firstname = TextEditingController().obs;
  final lastname = TextEditingController().obs;
  final state = TextEditingController().obs;
  final type = TextEditingController().obs;
  final location = TextEditingController().obs;
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

  var success = false.obs;

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

  void checkLogin() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      formKey.currentState!.save();
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

  registerWithEmailPassword(String? email, String? password) async {
    await GetxFire.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
        isSuccessDialog: true,
        onSuccess: (userCredential) async {
          success.isTrue;
          email = userCredential?.user!.email;
          print('$email, $userCredential');

          var data = UserModel(
              id: userCredential?.user!.uid,
              email: email,
              firstname: userCredential?.user!.displayName,
              lastname: lastname,
              phone: userCredential?.user!.phoneNumber,
              state: state,
              type: type,
              location: location,
              avatarUrl: userCredential?.user!.photoURL);

          await db.db.createData(
              collection: db.collection,
              data: data.toJson(),
              id: userCredential?.user!.uid,
              isErrorDialog: true,
              onError: (error) => GetxFire.openDialog.messageError(
                    error!,
                    title: 'Error register on cloud firestore',
                    duration: const Duration(seconds: 12),
                  ));

          GetxFire.openDialog.messageSuccess(
            "${userCredential?.additionalUserInfo!.isNewUser}",
            title: 'Register Successfully on : $email',
            duration: const Duration(seconds: 12),
          );

          Get.offAllNamed('/home');
        },
        onError: (code, msg) {
          success.isFalse;

          if (code == 'unknown') {
            GetxFire.openDialog.messageError(
              'select and complete a form before submit',
              title: 'Forms is empty',
              duration: const Duration(seconds: 12),
            );

          }

          if (code == 'email-already-in-use') {
            GetxFire.openDialog.messageError(
              msg!,
              title: code,
              duration: const Duration(seconds: 12),
            );
            Get.toNamed('/login', arguments: Get.arguments);
          }

          if (code == 'invalid-email') {
            GetxFire.openDialog.messageError(
              msg!,
              title: code,
              duration: const Duration(seconds: 12),
            );
            Get.back();
          }

          if (code == 'operation-not-allowed') {
            GetxFire.openDialog.messageError(
              msg!,
              title: code,
              duration: const Duration(seconds: 12),
            );
            Get.back();
          }

          if (code == 'weak-password') {
            GetxFire.openDialog.messageError(
              msg!,
              title: code,
              duration: const Duration(seconds: 12),
            );
            Get.back();
          }
        });
  }
}
