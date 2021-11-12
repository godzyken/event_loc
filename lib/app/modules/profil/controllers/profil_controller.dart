import 'package:event_loc/app/data/database/usd_db.dart';
import 'package:event_loc/app/data/models/models.dart' as u;
import 'package:event_loc/app/modules/auth/controllers/auth_controller.dart';
import 'package:event_loc/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class ProfilController extends GetxController {
  final _userModel = u.UserModel().obs;
  final authC = AuthController();
  final scrollerC = ScrollController();
  List<UserModel?> users = [];
  UserModelApi? api;
  FlutterUserApi? flutterUserApi;

  u.UserModel? get user => _userModel.value;

  set user(u.UserModel? value) => _userModel.value = value!;

  final formKey = GlobalKey<FormState>();

  get _formResult => formKey.currentState;

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
    UserModelApi.codec;
    SchedulerBinding.instance?.addPostFrameCallback((_) => onReady());
    FlutterUserApi.setup(FlutterUserApiHandler(
        (user) {
          this.user = user as u.UserModel?;
        }
    ));

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {
    // if (!condition) {
    //   return;
    // }
    // if (ids == null) {
    //   _userModel.update((val) {
    //     val!.id = ids!.first;
    //   });
    //   refresh();
    // } else {
    //   for (final id in ids) {
    //     refreshGroup(id);
    //   }
    // }
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  void clear() {
    _userModel.value = u.UserModel();
  }

  updateUser(firstname, lastname, email, phone, avatar, location, type, state) {
    db.editProfile(
        firstname, lastname, email, phone, avatar, location, type, state);
  }

  void submitForm() {
    var form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      print('New user saved with signup data:\n');
      print(_formResult.toJson());
    }
  }

  getUser() async {
    user = await Get.arguments['user'];
    print('Boss is $user');
    if (user!.email == email.value.text) {
      return await db.showUser();
    } else {
      return false;
    }
  }

  String? isFirstName(String? value) {
    if (!GetUtils.isUsername(value!) || value == '') {
      return 'Username format not valid';
    }
    return 'Username format ok!';
  }

  String? saveFirstName(String? newValue) {
    _userModel.update((val) {
      val!.firstname = user!.firstname ?? newValue;
    });

    _userModel.call();
  }

  String? islastName(String? value) {
    if (!GetUtils.isUsername(value!) || value == '') {
      return 'User lastname format not valid';
    }
    return 'User lastname format ok!';
  }

  String? saveLastName(String? newValue) {
    _userModel.update((val) {
      val!.lastname = user!.lastname ?? newValue;
    });

    _userModel.call();
  }

  String? isEmail(String? value) {
    if (!GetUtils.isEmail(value!) || value == '') {
      return 'Email format not valid';
    }
    return 'Email format ok!';
  }

  String? saveEmail(String? newValue) {
    _userModel.update((val) {
      val!.email = user!.email ?? newValue;
    });

    _userModel.call();
  }

  String? isPhone(String? value) {
    if (!GetUtils.isPhoneNumber(value!) || value == '') {
      return 'PhoneNumber format not valid';
    }
    return 'PhoneNumber format ok!';
  }

  savePhone(String? newValue) {
    _userModel.update((val) {
      val!.phone = user!.phone ?? newValue;
    });

    _userModel.call();
  }

  String? isAvatarUrl(String? value) {
    if (!GetUtils.isURL(value!) || value == '') {
      return 'AvatarUrl format not valid';
    }
    return 'AvatarUrl format ok!';
  }

  saveAvatar(String? newValue) {
    _userModel.update((val) {
      val!.avatarUrl = user!.avatarUrl ?? newValue;
    });

    _userModel.call();
  }

  String? isLocation(String? value) {
    if (!GetUtils.isTxt(value!) || value == '') {
      return 'street address format not valid';
    }
    return 'street address format ok!';
  }

  saveLocation(String? newValue) {
    _userModel.update((val) {
      val!.location = user!.location ?? newValue;
    });

    _userModel.call();
  }

  Future getUserId() async {
    final number = this.users.length + 1;

    final List<UserModel?> users =
        (UserModelApi.codec.encodeMessage(number)) as List<UserModel?>;
    final newUsers = List<UserModel>.from(users);
    this.users.addAll(newUsers);
    update();
  }

  Future deleteUserId(String? id) async {
    BinaryMessenger? message;

    if (GetUtils.isCurrency(id!)) {
      await api!.cancel();
    } else {
      final List<UserModel?> users =
          (UserModelApi.codec.encodeMessage(message)) as List<UserModel?>;
      for (var u in users) {
        if (u!.id == user!.id ) {
          this.users.removeWhere((user) => id == u.id);
        }
      }
    }

    update();
  }
}

typedef UserReceived = void Function(UserModel? userModel);

class FlutterUserApiHandler extends FlutterUserApi {
  FlutterUserApiHandler(this.callback);

  final UserReceived? callback;

  @override
  void displayUserDetails(UserModel? userModel) {
   assert(
   userModel != null,
   'Non-null user expected from flutterUserApi.displayUserProfile call.'
   );
   callback!(userModel);
  }
}
