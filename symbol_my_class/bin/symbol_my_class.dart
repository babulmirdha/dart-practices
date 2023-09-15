import 'dart:mirrors';

class MyClass {
  void sayHello() {
    print('Hello, World!');
  }
}

void main() {
  MyClass myInstance = MyClass();
  Symbol sayHelloSymbol = Symbol('sayHello');

  // Get the InstanceMirror for myInstance
  InstanceMirror im = reflect(myInstance);

  // Invoke the sayHello method using the Symbol
  im.invoke(sayHelloSymbol,[]);
}