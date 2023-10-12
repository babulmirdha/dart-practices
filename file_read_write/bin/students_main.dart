import 'dart:convert';
import 'dart:io';

void main() {
  var file = File("assets/students.json");

  var content = file.readAsStringSync();

  var list = jsonDecode(content);

  print(list.runtimeType);

  for (var map in list) {
    //print(map.runtimeType);

    // print("name: ${map['name']}");
    // print("dept: ${map['dept']}");
    // print("cgpa: ${map['cgpa']}");

    for (var key in map.keys) {
      print("$key: ${map[key]}");
    }

    // for(var entry in map.entries){
    //   print("${entry.key}: ${entry.value}");
    // }
  }
}
