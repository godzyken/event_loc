import 'package:pigeon/pigeon.dart';

class BookModel {
  String? title;
  String? urlImage;
}


@HostApi()
abstract class BookModelApi {
  List<BookModel?> search(String keyword);
}