import 'package:shelf/shelf.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

// Secret key for signing JWTs
const secretKey = 'super-secret-key';

// Middleware to check Authorization header for JWT token
Middleware checkAuth() {
  return (innerHandler) {
    return (request) {
      final authHeader = request.headers['Authorization'];

      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        return Response.forbidden('Missing or invalid Authorization header');
      }

      final token = authHeader.substring(7);
      try {
        final jwt = JWT.verify(token, SecretKey(secretKey));
        final username = jwt.payload['username'];
        return innerHandler(request.change(context: {'username': username}));
      } catch (_) {
        return Response.forbidden('Invalid or expired token');
      }
    };
  };
}

// Utility: Get username from request context
String? getUsernameFromRequest(Request request) {
  return request.context['username'] as String?;
}
