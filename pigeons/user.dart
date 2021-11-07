import 'package:flutter/material.dart';
import 'package:pigeon/pigeon.dart';
import 'package:reflectable/capability.dart';


class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? location;
  String? phone;
  String? avatarUrl;
  String? state;
  String? type;
}

class Reply {
  UserModel? userModel;
}

@FlutterApi()
abstract class UserModelApi {
  List<UserModel?> getUser(String keyword);
}
