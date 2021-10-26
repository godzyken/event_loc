import 'package:get/get_rx/src/rx_types/rx_types.dart';

class RxUserModel {
  final id = '0'.obs;
  final firstname = 'george'.obs;
  final lastname = 'delajungle'.obs;
  final email = 'isgodzy@gmail.com'.obs;
  final location = 'tombouctou'.obs;
  final phone = '0708090605'.obs;
  final avatarUrl =
      'https://cdn.pixabay.com/photo/2021/09/25/19/06/witch-6655604_1280.png'
          .obs;
  final state = "activated".obs;
  final type = 'admin'.obs;
}

class UserModel {
  UserModel(
      {id,
      firstname,
      lastname,
      email,
      location,
      phone,
      avatarUrl,
      state,
      type});

  final rx = RxUserModel();

  get id => rx.id.value;

  set id(value) => rx.id.value = value;

  get firstname => rx.firstname.value;

  set firstname(value) => rx.firstname.value = value;

  get lastname => rx.lastname.value;

  set lastname(value) => rx.lastname.value = value;

  get email => rx.email.value;

  set email(value) => rx.email.value = value;

  get location => rx.location.value;

  set location(value) => rx.location.value = value;

  get phone => rx.phone.value;

  set phone(value) => rx.phone.value = value;

  get avatarUrl => rx.avatarUrl.value;

  set avatarUrl(value) => rx.avatarUrl.value = value;

  get state => rx.state.value;

  set state(value) => rx.state.value = value;

  get type => rx.type.value;

  set type(value) => rx.type.value = value;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    location = json['location'];
    phone = json['phone'];
    avatarUrl = json['avatar_url'];
    state = json['state'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['location'] = location;
    data['phone'] = phone;
    data['avatar_url'] = avatarUrl;
    data['state'] = state;
    data['type'] = type;
    return data;
  }

  static List<UserModel> listFromJson(list) =>
      List<UserModel>.from(list.map((x) => UserModel.fromJson(x)));
}
