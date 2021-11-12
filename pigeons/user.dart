import 'package:pigeon/pigeon.dart';


class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? location;
  String? phone;
  AvatarUrl? avatarUrl;
  String? state;
  String? type;
}

class AvatarUrl {
  String? url;
}

@FlutterApi()
abstract class FlutterUserApi {
  void displayUserDetails(UserModel userModel);
}

@HostApi()
abstract class UserModelApi {
  List<UserModel?> getUser(String keyword);
  void cancel();
  void finishEditingProfile(UserModel userModel);
}
