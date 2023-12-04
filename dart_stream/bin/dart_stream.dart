
import 'dart:async';

Future<void> main() async {
  // Create a stream controller
  var controller = StreamController<String>();

  // Create a stream from the controller
  var stream = controller.stream;

  // Subscribe to the stream
  var subscription = stream.listen((data) {
    print('Received data: $data');
  });

  // Add some events to the stream
  controller.add('Position (1,2)');
  await Future.delayed(Duration(seconds: 5));
  controller.add('Position (2,3)');

  // Close the stream
  controller.close();

  // Cancel the subscription
  //subscription.cancel();
}
