// Base class
abstract class Shape {
  double calculateArea();
}

// Circle class
class Circle extends Shape {
  double radius;

  Circle(this.radius);

  @override
  double calculateArea() {
    return 3.14 * radius * radius;
  }
}

// Rectangle class
class Rectangle extends Shape {
  double length;
  double width;

  Rectangle(this.length, this.width);

  @override
  double calculateArea() {
    return length * width;
  }
}

void main() {
  Shape circle = Circle(5.0);
  Shape rectangle = Rectangle(4.0, 6.0);

  print('Area of the circle: ${circle.calculateArea()}');       // Output: Area of the circle: 78.5
  print('Area of the rectangle: ${rectangle.calculateArea()}'); // Output: Area of the rectangle: 24.0
}