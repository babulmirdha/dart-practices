import 'dart:convert';
import 'dart:io';

void main(){

  var file = File("assets/student.json");

  var content = file.readAsStringSync();

  print(content);
  print(content.runtimeType);

  var map = jsonDecode(content);

  print(map);

  print(map.runtimeType);

  print(map['name']);
  print(map['dept']);
  print(map['cgpa']);

  for(MapEntry me in map.entries ){
    print("${me.key}: ${me.value}");
  }


}