import 'dart:io';

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:path/path.dart' as p;

final dbFilePath = p.join(Directory.current.path, 'db.json');

// Read JSON data from file
Map<String, dynamic> readData() {
  try {
    final file = File(dbFilePath);
    if (!file.existsSync()) {
      file.writeAsStringSync(jsonEncode({'products': []}));
    }
    final content = file.readAsStringSync();
    return jsonDecode(content);
  } catch (e) {
    print('Read error: $e');
    return {'products': []};
  }
}

// Write JSON data to file
void writeData(Map<String, dynamic> data) {
  try {
    final file = File(dbFilePath);
    file.writeAsStringSync(jsonEncode(data));
  } catch (e) {
    print('Write error: $e');
  }
}

Response _jsonResponse(dynamic data, {int statusCode = 200}) {
  return Response(statusCode,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'});
}

Router get router {
  final router = Router();

  // GET all products
  router.get('/products', (Request request) {
    final data = readData();
    return _jsonResponse(data['products']);
  });

  // GET product by ID
  router.get('/products/<id|[0-9]+>', (Request request, String id) {
    final data = readData();
    final product = data['products']
        .firstWhere((p) => p['id'] == int.parse(id), orElse: () => null);

    return product != null
        ? _jsonResponse(product)
        : _jsonResponse({'error': 'Product not found'}, statusCode: 404);
  });

  // POST: Create product
  router.post('/products', (Request request) async {
    final payload = await request.readAsString();
    final body = jsonDecode(payload);

    final data = readData();
    final products = data['products'] as List;

    final newProduct = {
      'id': products.length + 1,
      'name': body['name'],
      'price': body['price'],
      'description': body['description'],
    };

    products.add(newProduct);
    writeData(data);

    return _jsonResponse(newProduct, statusCode: 201);
  });

  // PUT: Update product
  router.put('/products/<id|[0-9]+>', (Request request, String id) async {
    final payload = await request.readAsString();
    final body = jsonDecode(payload);

    final data = readData();
    final products = data['products'] as List;
    final index = products.indexWhere((p) => p['id'] == int.parse(id));

    if (index == -1) {
      return _jsonResponse({'error': 'Product not found'}, statusCode: 404);
    }

    final updatedProduct = {
      'id': int.parse(id),
      'name': body['name'],
      'price': body['price'],
      'description': body['description'],
    };

    products[index] = updatedProduct;
    writeData(data);

    return _jsonResponse(updatedProduct);
  });

  // DELETE: Remove product
  router.delete('/products/<id|[0-9]+>', (Request request, String id) {
    final data = readData();
    final products = data['products'] as List;
    final index = products.indexWhere((p) => p['id'] == int.parse(id));

    if (index == -1) {
      return _jsonResponse({'error': 'Product not found'}, statusCode: 404);
    }

    products.removeAt(index);
    writeData(data);

    return _jsonResponse({'message': 'Product deleted successfully'});
  });

  return router;
}

void main() async {
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router.call);

  final server = await shelf_io.serve(handler, 'localhost', 3000);
  print('✅ Server running at http://localhost:${server.port}');
}
