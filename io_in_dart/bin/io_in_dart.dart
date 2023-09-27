import 'dart:ffi';
import 'dart:io';

int add(int a, int b) {
  int c = a + b;
  return c;
}

void main() {
  int x;

  int y;

  print("X?");

  x = int.parse(stdin.readLineSync()!);

  print("y?");
  y = int.parse(stdin.readLineSync()!);

  var sum = add(x, y);


  print( "Sum = $sum");

  print("Enter name:");
  String? name = stdin.readLineSync();
  print("The entered name is ${name}");
}
