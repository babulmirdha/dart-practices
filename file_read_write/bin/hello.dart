import 'dart:io';

void main() async {
  var file = File("assets/hello.txt");

  var content = await file.readAsString(); // Sync

  print("Sync: $content");

  var content1 = file.readAsStringSync(); // Sync

  print("Sync: $content1");

  file.readAsString().then((value) => {
    print("async: $value")
  }); // Sync




}
