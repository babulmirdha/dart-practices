import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter( ),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

void demo() {

  logger.d('Log message with 2 methods');

  loggerNoStack.i('Info message');

  loggerNoStack.w('Just a warning!');

  logger.e('Error! Something bad happened', error: 'Test Error');

  loggerNoStack.t({'key': 5, 'value': 'something'});

  Logger(printer: SimplePrinter(colors: true)).t('boom');
}

void main() {
  print("Start line");
  print(
      'Run with either `dart example/main.dart.dart` or `dart --enable-asserts example/main.dart.dart`.');
  demo();

  print("End line");
}