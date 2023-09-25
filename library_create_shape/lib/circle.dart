part of shape;

class Circle extends Shape {
  double _radius;
  Circle({required double radius}) : _radius = radius;
  double get area => pi * pow(_radius, 2);
}
