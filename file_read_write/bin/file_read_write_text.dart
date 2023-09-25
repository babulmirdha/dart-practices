import 'dart:async';
import 'dart:io';

void main() async {
  final filename = 'assets/persons.json';

  var personsFile = File(filename);

  //Reading from file
  personsFile.readAsString().then((String contents) {
    print(contents);
  });

}
