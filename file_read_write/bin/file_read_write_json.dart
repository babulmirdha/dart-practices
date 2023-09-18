import 'dart:async';
import 'dart:io';

void main() async {
  final filename = 'assets/file.txt';

  var myFile = File(filename);

  //Reading from file
  myFile.readAsString().then((String contents) {
    print(contents);
  });

//Write to file
  var file = await File(filename).writeAsString('some content');
}
