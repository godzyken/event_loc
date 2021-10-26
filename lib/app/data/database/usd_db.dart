import 'package:event_loc/app/data/models/user_model.dart';
import 'package:getxfire/getxfire.dart';

class UserDb {
  var auth = GetxFire.auth;
  var db = GetxFire.firestore;
  var collection = 'users';


  addNewUser(String? phone) async {
    var id = auth.currentUser!.uid;
    var currentUserInfo = await db.getData(
        collection: collection,
        ownerUID: id,
        onError: (err) =>
            GetxFire.openDialog.messageError(
                'error fetch data failed: $err',
                title: 'Error data not found',
                duration: Duration(seconds: 12)
            ),
    );

    if (currentUserInfo.isEmpty) {
      await db.createData(
          collection: 'users',
          data: UserModel(
            id: id,
            firstname: "",
            lastname: "",
            email: "",
            phone: phone,
            avatarUrl: "",
            location: "",
            type: "",
            state: "",
          ).toJson()
      );
    }
  }

  editProfile(firstname, lastname, email, phone, avatar, location, type, state) async {
    var id = auth.currentUser!.uid;
    await db.updateData(
        collection: collection,
        id: id,
        data: UserModel(
          id: id,
          firstname: firstname,
          lastname: lastname,
          email: email,
          phone: phone,
          avatarUrl: avatar,
          location: location,
          type: type,
          state: state,
        ).toJson()
    );
  }

  showUser() async {
    var id = auth.currentUser!.uid;
    var userInfo = await db.getDetail(
        collection: collection,
        id: id,
    );
    var obj = UserModel.fromJson(userInfo.get(Object));

    return obj;
  }
}