import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import 'routes/auth_routes.dart';
import 'routes/product_routes.dart';
import 'middlewares/checkAuth.dart';

void main() async {

  setupUserDatabase();
  setupProductDatabase();


  final router = Router();

  // Mount auth and product routes
  router.mount('/api/auth/', authRoutes());
  router.mount('/api/prodeucts/', productRoutes());


  final handler = Pipeline()
      .addMiddleware(logRequests())
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

  final server = await io.serve(handler, InternetAddress.anyIPv4, 5000);
  print('✅ Server running on http://localhost:${server.port}');
}
