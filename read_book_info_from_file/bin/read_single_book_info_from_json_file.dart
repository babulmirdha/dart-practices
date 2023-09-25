import 'dart:convert';
import 'dart:io';

import 'package:read_book_info_from_file/book.dart';

void main(){

  var file = File("assets/book.json");


  Book? book;

  file.readAsString().then((value) {

    Map data = jsonDecode(value);

    book = Book(data['title'], data['author'], data['price']);

    print(data.runtimeType);


    data.forEach((key, value) {

      print("$key:$value");

    });


  });


  print(book);


}
