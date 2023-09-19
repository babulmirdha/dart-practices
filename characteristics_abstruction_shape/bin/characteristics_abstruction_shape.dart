// Abstract class
abstract class Shape {
  // Abstract method
  double calculateArea();

  // Abstract methods can have regular (non-abstract) methods too
  void printDescription() {
    print('This is a shape.');
  }
}

// Concrete subclass
class Circle extends Shape {
  double radius;

  Circle(this.radius);

  @override
  double calculateArea() {
    return 3.14 * radius * radius;
  }

  @override
  void printDescription() {
    print('This is a circle with radius $radius');
  }
}

// Concrete subclass
class Rectangle extends Shape {
  double length;
  double width;

  Rectangle(this.length, this.width);

  @override
  double calculateArea() {
    return length * width;
  }

  @override
  void printDescription() {
    print('This is a rectangle with length $length and width $width');
  }
}

void main() {
  Shape circle = Circle(5.0);
  Shape rectangle = Rectangle(4.0, 6.0);

  circle.printDescription();    // Output: This is a circle with radius 5.0
  print('Area of the circle: ${circle.calculateArea()}');       // Output: Area of the circle: 78.5

  rectangle.printDescription(); // Output: This is a rectangle with length 4.0 and width 6.0
  print('Area of the rectangle: ${rectangle.calculateArea()}'); // Output: Area of the rectangle: 24.0
}