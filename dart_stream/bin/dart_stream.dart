
import 'dart:async';

void main() {
  // Create a stream controller
  var controller = StreamController<String>();

  // Create a stream from the controller
  var stream = controller.stream;

  // Subscribe to the stream
  var subscription = stream.listen((data) {
    print('Received data: $data');
  });

  // Add some events to the stream
  controller.add('Event 1');
  controller.add('Event 2');

  // Close the stream
  controller.close();

  // Cancel the subscription
  subscription.cancel();
}
