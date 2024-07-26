// response_extensions.dart
import 'package:shelf/shelf.dart';
import 'dart:convert';

extension ResponseConflict on Response {
  static Response conflict(Object? body, {Map<String, String>? headers}) {
    return Response(
      409, // HTTP status code for Conflict
      body: jsonEncode(body),
      headers: headers ?? {'Content-Type': 'application/json'},
    );
  }
}
