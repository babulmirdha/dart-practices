class MyClass<T> {
  covariant T myValue;

  MyClass(this.myValue);

  void printValue() {
    print('My value: $myValue');
  }
}

void main() {
  MyClass<String> stringObject = MyClass<String>('Hello, World!');
  stringObject.printValue(); // Output: My value: Hello, World!

  MyClass<num> numericObject = MyClass<int>(42);
  numericObject.printValue(); // Output: My value: 42
}