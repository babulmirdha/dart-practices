import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:sqlite3/sqlite3.dart';

// Use the same database
final db = sqlite3.open('ecommerce.db');

// Setup product table
void setupProductDatabase() {
  db.execute('''
    CREATE TABLE IF NOT EXISTS products (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      price REAL NOT NULL
    );
  ''');
}

// Router for product-related routes
Router productRoutes() {
  final router = Router();

  // GET /api/products
  router.get('/', (Request request) {
    final result = db.select('SELECT * FROM products');
    final products = result
        .map((row) => {'id': row['id'], 'name': row['name'], 'price': row['price']})
        .toList();

    return Response.ok(jsonEncode(products), headers: {'Content-Type': 'application/json'});
  });

  // GET /api/products/<id>
  router.get('/<id|[0-9]+>', (Request request, String id) {
    final result = db.select('SELECT * FROM products WHERE id = ?', [int.parse(id)]);
    if (result.isEmpty) {
      return Response.notFound('Product not found');
    }
    final row = result.first;
    final product = {'id': row['id'], 'name': row['name'], 'price': row['price']};

    return Response.ok(jsonEncode(product), headers: {'Content-Type': 'application/json'});
  });

  // POST /api/products
  router.post('/', (Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);

    final name = data['name'];
    final price = data['price'];

    db.execute('INSERT INTO products (name, price) VALUES (?, ?)', [name, price]);

    return Response.ok(jsonEncode({'message': 'Product added'}), headers: {'Content-Type': 'application/json'});
  });

  // DELETE /api/products/<id>
  router.delete('/<id|[0-9]+>', (Request request, String id) {
    db.execute('DELETE FROM products WHERE id = ?', [int.parse(id)]);
    return Response.ok(jsonEncode({'message': 'Product deleted'}), headers: {'Content-Type': 'application/json'});
  });

  return router;
}
