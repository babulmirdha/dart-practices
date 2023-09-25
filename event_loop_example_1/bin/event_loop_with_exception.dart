
Future<void> main() async {
  print(1);
  try {
    var value = await Future<int>.delayed(
        Duration(seconds: 2),
            () => throw Exception('An error from the future'));
    print(value);
  } catch (e) {
    print(e);
  }
  print(3);
}
