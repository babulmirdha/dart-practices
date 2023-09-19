import 'dart:async';

void main() {
  // Add a microtask to the microtask queue.
  Future.delayed(Duration(seconds: 1), () {
    print('Microtask');
  });

  // Add an event to the event queue.
  Timer(Duration(seconds: 2), () {
    print('Event');
  });

  // The event loop will now start executing the microtask and event queue.
}