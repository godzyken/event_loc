import 'package:pigeon/pigeon.dart';

class BookModel {
  String? title;
  String? urlImage;
  String? author;
  String? summary;
  String? publishDate;
  int? pageCount;
  Thumbnail? thumbnail;
}

class Thumbnail {
  String? url;
}

@FlutterApi()
abstract class FlutterBookApi {
  void displayBookDetails(BookModel bookModel);
}

@HostApi()
abstract class BookModelApi {
  List<BookModel?> search(String keyword);
  void cancel();
  void finishEditingBook(BookModel bookModel);
}