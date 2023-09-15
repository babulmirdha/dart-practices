import 'package:symbol_my_class/symbol_my_class.dart' as symbol_my_class;

class MyClass {
  void doSomething() {
    print('Doing something');
  }
}

void main() {
  var symbol = #doSomething; // Create a symbol
  var myInstance = MyClass();

  // Access a class member using the symbol
  myInstance.invoke(symbol);

  // Using a symbol as a key in a map
  var symbolMap = {symbol: 'This is a symbol key'};
  print(symbolMap[symbol]); // Access the value using the symbol
}