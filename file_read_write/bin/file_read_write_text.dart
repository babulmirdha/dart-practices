import 'dart:async';
import 'dart:io';

void main() async {
  final filename = 'assets/persons.json';

  var personsFile = File(filename);

  fn(String contents) {
    print(contents);
  }

  //Reading from file
  personsFile.readAsString().then(fn);

}
