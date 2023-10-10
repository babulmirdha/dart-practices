import 'dart:io';

void main() async {
  final filename = 'assets/persons.json';

  var personsFile = File(filename);

  //async: Reading from file
  personsFile.readAsString().then((String contents) {
    print(contents);
  });



  // Sync
  // var contents = await personsFile.readAsString();
  //
  // print(contents);

  print("End Line");
}
