import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:mongo_dart/mongo_dart.dart';

// MongoDB configuration
const mongoUri = 'mongodb://localhost:27017/products_db';
late Db db;
late DbCollection productsCollection;

// Helper to send JSON response
Response _jsonResponse(dynamic data, {int statusCode = 200}) {
  return Response(statusCode,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'});
}

Router get router {
  final router = Router();

  // GET all products
  router.get('/api/products', (Request request) async {
    final products = await productsCollection.find().toList();
    return _jsonResponse(products);
  });

  // GET product by ID
  router.get('/api/products/<id>', (Request request, String id) async {
    final product = await productsCollection.findOne(where.id(ObjectId.parse(id)));
    return product != null
        ? _jsonResponse(product)
        : _jsonResponse({'error': 'Product not found'}, statusCode: 404);
  });

  // POST: Create product
  router.post('/api/products', (Request request) async {
    final payload = await request.readAsString();
    final body = jsonDecode(payload);

    final newProduct = {
      'name': body['name'],
      'price': body['price'],
      'description': body['description'],
    };

    final result = await productsCollection.insertOne(newProduct);
    return _jsonResponse({...newProduct, '_id': result.id}, statusCode: 201);
  });

  // PUT: Update product
  router.put('/api/products/<id>', (Request request, String id) async {
    final payload = await request.readAsString();
    final body = jsonDecode(payload);

    final selector = where.id(ObjectId.parse(id));
    final existing = await productsCollection.findOne(selector);
    if (existing == null) {
      return _jsonResponse({'error': 'Product not found'}, statusCode: 404);
    }

    final updatedProduct = {
      'name': body['name'],
      'price': body['price'],
      'description': body['description'],
    };

    await productsCollection.updateOne(selector, modify.set('name', updatedProduct['name'])
        .set('price', updatedProduct['price'])
        .set('description', updatedProduct['description']));

    return _jsonResponse({'_id': id, ...updatedProduct});
  });

  // DELETE: Remove product
  router.delete('/api/products/<id>', (Request request, String id) async {
    final result =
    await productsCollection.deleteOne(where.id(ObjectId.parse(id)));
    if (result.nRemoved == 0) {
      return _jsonResponse({'error': 'Product not found'}, statusCode: 404);
    }

    return _jsonResponse({'message': 'Product deleted successfully'});
  });

  return router;
}

void main() async {
  db = await Db.create(mongoUri);
  await db.open();
  productsCollection = db.collection('products');

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router.call);

  final server = await shelf_io.serve(handler, 'localhost', 3000);
  print('✅ Server running at http://localhost:${server.port}');
}
