import 'package:event_loop_example_1/event_loop_example_1.dart' as event_loop_example_1;

void main(List<String> arguments) {
  print("Before:1");

  var future = Future<int>.delayed(Duration(seconds: 2), () => 2);

  future.then((value) => print("Middle: $value"))
      .whenComplete(() => print("completed"))
      .catchError((e)=>print(e));

  print("After:3");
}
