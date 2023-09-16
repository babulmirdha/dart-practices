import 'dart:convert';
import 'dart:io';

List<dynamic> readJsonFile(String filePath) {
  var jsonFile =  File(filePath).readAsStringSync();

  var map = jsonDecode(jsonFile);

  var users = map['users'] as List<dynamic>;

  print("x: ${users.runtimeType}");
  print("users: $users");

  return users;
}


void main(List<String> arguments) async {

  final filename = 'assets/users.json';

  var users = readJsonFile(filename);


  for(var user in users){
    print(user);
  }

//  print(users);
}
