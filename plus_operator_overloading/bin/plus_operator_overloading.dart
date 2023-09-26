
import 'package:plus_operator_overloading/point.dart';

void main(List<String> arguments) {

  var p1 = Point(x:10, y:20);
  var p2 = Point(x:30, y:50);

  var x = p1.x + p2.x;
  var y = p1.y + p2.y;

  print("x=$x, y=$y");

  var p3 = p1 + p2;

  print("${p3.x}, ${p3.y}");

}
