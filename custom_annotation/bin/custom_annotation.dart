// Custom annotation class
class MyCustomAnnotation {
  final String message;

  const MyCustomAnnotation(this.message);
}

// Annotating a class with the custom annotation
@MyCustomAnnotation("This is a custom annotation example.")
class MyClass {
  // Class implementation
}

void main() {
  // Accessing the annotation
  final annotation = MyCustomAnnotation("This is a custom annotation example.");

  // Accessing the message property of the annotation
  print(annotation.message); // Output: This is a custom annotation example.
}
