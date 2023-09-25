
Future<void> main() async {
  print(1);

  var value = await Future<int>.delayed(
      Duration(seconds: 5),
          () => 2
  );

  print(value);

  print(3);
}
