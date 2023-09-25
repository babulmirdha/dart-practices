

part of shape;

class Square extends Shape {
  double _length;
  Square({required double length}) : _length = length;
  double get area => pow(_length, 2) as double;
}
