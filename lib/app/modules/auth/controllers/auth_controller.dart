import 'package:event_loc/user.dart';
import 'package:flutter/services.dart';
import 'package:event_loc/app/data/models/user_model.dart' as u;
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../../../book.dart';

class AuthController extends GetxController {
  static const methodChannel = MethodChannel('godzy.flutter.dev/home');
  static const authChannel = EventChannel('godzy.flutter.dev/authChannel');
  static RemoteConfig? _remoteConfig;

  final auth = GetxFire.auth;
  List<BookModel?> books = [];

  User? get currentUser => auth.currentUser;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeRemoteConfig();
    update();
  }

  @override
  void onReady() {
    super.onReady();
    update();
  }

  @override
  void onClose() {}

  // Future<void> _checkAvailableAuth() async {
  //   try {
  //     await methodChannel.invokeMethod('isAuthActivity');
  //   }
  // }

  Future getBook() async {
    final number = this.books.length + 1;
    final List<BookModel?> books = await BookModelApi().search('Book $number');
    final newBooks = List<BookModel>.from(books);
    this.books.addAll(newBooks);
    update();
  }

  getConnectionToFirebase() async {
    final user = currentUser!.getIdToken(false).then((value) =>
        UserModelApi.codec.encodeMessage(value));
    print(user);
  }

  _initializeRemoteConfig() async {
    var fetchTimeout = const Duration(seconds: 3600);
    var minimumFetchInterval = const Duration(milliseconds: 21600000);

    if (_remoteConfig == null) {
      _remoteConfig = RemoteConfig.instance;

      final model = u.UserModel().toJson();

      await _remoteConfig?.setDefaults(model);

      _remoteConfig?.setConfigSettings(
          RemoteConfigSettings(
              fetchTimeout: fetchTimeout,
              minimumFetchInterval: minimumFetchInterval
          )
      );

      await _fetchRemoteConfig();
    }

    isLoading.value = false;
  }

  _fetchRemoteConfig() async {
    try {
      await _remoteConfig?.fetch();
      await _remoteConfig?.fetchAndActivate();

      print('Last fetch status: ' + _remoteConfig!.lastFetchStatus.toString());
      print('Last fetch time: ' + _remoteConfig!.lastFetchTime.toString());
      print('New user enabled?: ' + _remoteConfig!.getBool('new user connected').toString());

      _remoteConfig!.getBool('new user online') ? UserModel().id : u.UserModel().id;
    } catch (e) {
      print('Error: ${e.toString()}');
    }

  }
}
