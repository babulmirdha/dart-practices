import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

late Database db;

void initDb() {
  final dbPath = p.join(Directory.current.path, 'products.db');
  db = sqlite3.open(dbPath);
  db.execute('''
    CREATE TABLE IF NOT EXISTS products (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      price REAL NOT NULL,
      description TEXT
    )
  ''');
}

// Map Row to Map<String, dynamic> using fixed column indexes
Map<String, dynamic> rowToMap(Row row) {
  return {
    'id': row[0],
    'name': row[1],
    'price': row[2],
    'description': row[3],
  };
}

Response _jsonResponse(dynamic data, {int statusCode = 200}) {
  return Response(statusCode,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'});
}

Router get router {
  final router = Router();

  // GET all products
  router.get('/api/products', (Request request) {
    final result = db.select('SELECT * FROM products');
    final products = result.map(rowToMap).toList();
    return _jsonResponse(products);
  });

  // GET product by ID
  router.get('/api/products/<id|[0-9]+>', (Request request, String id) {
    final result = db.select(
      'SELECT * FROM products WHERE id = ?',
      [int.parse(id)],
    );
    if (result.isEmpty) {
      return _jsonResponse({'error': 'Product not found'}, statusCode: 404);
    }
    return _jsonResponse(rowToMap(result.first));
  });

  // POST: Create product
  router.post('/api/products', (Request request) async {
    final payload = await request.readAsString();
    final body = jsonDecode(payload);

    final stmt = db.prepare(
        'INSERT INTO products (name, price, description) VALUES (?, ?, ?)');
    stmt.execute([body['name'], body['price'], body['description']]);
    stmt.dispose();

    final id = db.lastInsertRowId;

    return _jsonResponse({
      'id': id,
      'name': body['name'],
      'price': body['price'],
      'description': body['description']
    }, statusCode: 201);
  });

  // PUT: Update product
  router.put('/api/products/<id|[0-9]+>', (Request request, String id) async {
    final payload = await request.readAsString();
    final body = jsonDecode(payload);

    final result = db.select('SELECT * FROM products WHERE id = ?', [int.parse(id)]);
    if (result.isEmpty) {
      return _jsonResponse({'error': 'Product not found'}, statusCode: 404);
    }

    final stmt = db.prepare(
        'UPDATE products SET name = ?, price = ?, description = ? WHERE id = ?');
    stmt.execute([body['name'], body['price'], body['description'], int.parse(id)]);
    stmt.dispose();

    return _jsonResponse({
      'id': int.parse(id),
      'name': body['name'],
      'price': body['price'],
      'description': body['description']
    });
  });

  // DELETE: Remove product
  router.delete('/api/products/<id|[0-9]+>', (Request request, String id) {
    final stmt = db.prepare('DELETE FROM products WHERE id = ?');
    stmt.execute([int.parse(id)]);
    stmt.dispose();

    if (db.getUpdatedRows() == 0) {
      return _jsonResponse({'error': 'Product not found'}, statusCode: 404);
    }

    return _jsonResponse({'message': 'Product deleted successfully'});
  });

  return router;
}

void main() async {

  //init database
  initDb();

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router.call);

  final server = await shelf_io.serve(handler, '192.168.10.249', 3000);
  print('✅ Server running at http://192.168.10.249:${server.port}');
}
