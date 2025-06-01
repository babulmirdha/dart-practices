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
        final email = jwt.payload['email'];
        return innerHandler(request.change(context: {'email': email}));
      } catch (_) {
        return Response.forbidden('Invalid or expired token');
      }
    };
  };
}

// Utility: Get email from request context
String? getUsernameFromRequest(Request request) {
  return request.context['email'] as String?;
}
