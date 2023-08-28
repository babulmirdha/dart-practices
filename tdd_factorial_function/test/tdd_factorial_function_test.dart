import 'package:tdd_factorial_function/tdd_factorial_function.dart';
import 'package:test/test.dart';

void main() {
  // test('Factorial of 0 should be 1', () {
  //   expect(factorial(0), equals(1));
  // });
  // test('Factorial of 1 should be 1', () {
  //   expect(factorial(1), equals(1));
  // });
  // test('Factorial of 5 should be 120', () {
  //   expect(factorial(5), equals(120));
  // });
  // test('Factorial of 10 should be 3628800', () {
  //   expect(factorial(10), equals(3628800));
  // });
  // test('Factorial of a negative number should throw an exception', () {
  //   expect(() => factorial(-5), throwsA(isA<ArgumentError>()));
  // });
  test('Factorial of a non-integer should throw an exception', () {
    expect(() => factorial(3.14), throwsA(isA<ArgumentError>()));
  });
}