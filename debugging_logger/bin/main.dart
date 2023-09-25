import 'package:logger/logger.dart';

void main() {

var  logger = Logger(  printer: PrettyPrinter(methodCount: 5));

logger.t("Trace log");

logger.d("Debug log");

logger.i("Info log");

logger.w("Warning log");

logger.e("Error log", error: null);

logger.f("What a fatal log", error: null, stackTrace: null);


}