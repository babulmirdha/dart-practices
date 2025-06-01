import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:sqlite3/sqlite3.dart';

const secretKey = 'super-secret-key';

// SQLite instance
final db = sqlite3.open('ecommerce.db');

// Setup DB schema
void setupUserDatabase() {
  db.execute('''
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE,
  password TEXT,
  name TEXT,
  gender TEXT,
  dob TEXT
);

  ''');
}

// JWT generator
String generateToken(String username) {
  final jwt = JWT({'username': username});
  return jwt.sign(SecretKey(secretKey), expiresIn: Duration(hours: 1));
}

// Auth routes
Router authRoutes() {
  final router = Router();

  // Signup
  router.post('/signup', (Request request) async {
    final body = await request.readAsString();
    final data = jsonDecode(body);

    final username = data['username'];
    final password = data['password'];
    final name = data['name'];
    final gender = data['gender'];
    final dob = data['dob'];

    try {
      db.execute('''
        INSERT INTO users (username, password, name, gender, dob)
        VALUES (?, ?, ?, ?, ?)
      ''', [username, password, name, gender, dob]);

      final token = generateToken(username);
      return Response.ok(jsonEncode({'token': token}), headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return Response(409, body: 'User already exists');
    }
  });

  // Signin
  router.post('/signin', (Request request) async {
    final body = await request.readAsString();
    final data = jsonDecode(body);

    final username = data['username'];
    final password = data['password'];

    final result = db.select('SELECT * FROM users WHERE username = ? AND password = ?', [username, password]);

    if (result.isNotEmpty) {
      final token = generateToken(username);
      return Response.ok(jsonEncode({'token': token}), headers: {'Content-Type': 'application/json'});
    } else {
      return Response.forbidden('Invalid credentials');
    }
  });

  // Me (protected)
  router.get('/me', (Request request) {
    final username = request.context['username'];

    final result = db.select('SELECT username, name, gender, dob FROM users WHERE username = ?', [username]);

    if (result.isEmpty) {
      return Response.notFound('User not found');
    }

    final user = result.first;
    return Response.ok(
      jsonEncode({
        'username': user['username'],
        'name': user['name'],
        'gender': user['gender'],
        'dob': user['dob'],
      }),
      headers: {'Content-Type': 'application/json'},
    );
  });

  return router;
}

