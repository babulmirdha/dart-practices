abstract class Logger {
  void log(String message);
}

class ConsoleLogger implements Logger {
  @override
  void log(String message) {
    print('Log "$message" to the console.');
  }
}

class FileLogger implements Logger {
  @override
  void log(Pattern message) {
    print('Log "$message" to a file.');
  }
}

class App {
  Logger? logger;
  App({this.logger});

  void run() {
    logger?.log("App is starting...");
  }
}

void main() {
  // can use configuration file to select
  // kind of loggger to use
  var app = App(logger: ConsoleLogger());
  app.run();
}