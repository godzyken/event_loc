import 'package:event_loc/user.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

import '../../../../book.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

  final auth = GetxFire.auth;
  List<BookModel?> books = [];

  User? get currentUser => auth.currentUser;

  @override
  void onInit() {
    super.onInit();
    update();
  }

  @override
  void onReady() {
    super.onReady();
    update();
  }

  @override
  void onClose() {}

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
}
