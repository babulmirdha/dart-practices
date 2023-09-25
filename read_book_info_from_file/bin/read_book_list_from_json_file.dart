import 'dart:convert';
import 'dart:io';

import 'package:read_book_info_from_file/book.dart';

void main(List<String> arguments) {
  var file = File("assets/books.json");

  List<Book> books = [];

  file.readAsString().then((value) {
    print(value.runtimeType);

    var data = jsonDecode(value);

    print(data.runtimeType);

    for (var m in data) {
      // print(m['title']);
      // print(m['author']);
      // print(m['price']);

      books.add(Book(m['title'], m['author'], m['price']));
    }

    for(var book in books){
      print(book);
    }

  });



}
