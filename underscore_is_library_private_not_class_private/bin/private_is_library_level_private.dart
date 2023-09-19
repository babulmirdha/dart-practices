import 'package:underscore_is_library_private_not_class_private/point.dart';


void main() {
  var p1 = Point(x: 10, y: 20);
  p1.show();

  print("${p1.x}, ${p1.y}");

  p1.x = 50;
  p1.y = 50;

  p1.show();
}
