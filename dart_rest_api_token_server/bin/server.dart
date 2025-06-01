import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import 'routes/auth_routes.dart';
import 'routes/product_routes.dart';
import 'middlewares/checkAuth.dart';
import 'middlewares/corsMiddleware.dart';

void main() async {

  setupUserDatabase();
  setupProductDatabase();


  final router = Router();

  // Mount auth and product routes
  router.mount('/api/auth/', authRoutes());
  router.mount('/api/prodeucts/', productRoutes());


  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsMiddleware()) // 👈 Add here
      .addMiddleware((innerHandler) {
    // Protect only /api/auth/me for now
    return (request) {
      if (request.url.path == 'api/auth/me') {
        return checkAuth()(innerHandler)(request);
      }
      return innerHandler(request);
    };
  })
      .addHandler(router);

  // final server = await io.serve(handler, InternetAddress.anyIPv4, 5000);
  final server = await io.serve(handler, "192.168.10.249", 3000);
  print('✅ Server running on http://192.168.10.249:${server.port}');
}
