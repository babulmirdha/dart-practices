import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Extension method to add firstWhereOrNull to List
extension FirstWhereOrNullExtension<E> on List<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

class Student {
  String id;
  String name;
  int age;

  Student({required this.id, required this.name, required this.age});

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'age': age};

  static Student fromJson(Map<String, dynamic> json) =>
      Student(id: json['id'], name: json['name'], age: json['age']);
}

final List<Student> students = [
  Student(id: "001", name: "Babul Mirdha", age: 25),
  Student(id: "002", name: "Iqbal Hossain", age: 21)
];

Response _handleGetAll(Request request) {
  return Response.ok(
    jsonEncode(students.map((s) => s.toJson()).toList()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response _handleGetById(Request request, String id) {
  final Student? student = students.firstWhereOrNull((s) => s.id == id);
  if (student == null) {
    return Response.notFound('Student not found');
  }
  return Response.ok(
    jsonEncode(student.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> _handleCreate(Request request) async {
  final payload = await request.readAsString();
  final data = jsonDecode(payload);
  final student = Student.fromJson(data);
  students.add(student);
  return Response.ok(
    jsonEncode(student.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> _handleUpdate(Request request, String id) async {
  final payload = await request.readAsString();
  final data = jsonDecode(payload);
  final Student? student = students.firstWhereOrNull((s) => s.id == id);
  if (student == null) {
    return Response.notFound('Student not found');
  }
  student.name = data['name'];
  student.age = data['age'];
  return Response.ok(
    jsonEncode(student.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> _handlePatch(Request request, String id) async {
  final payload = await request.readAsString();
  final data = jsonDecode(payload);
  final Student? student = students.firstWhereOrNull((s) => s.id == id);
  if (student == null) {
    return Response.notFound('Student not found');
  }
  student.name = data['name'] ?? student.name;
  student.age = data['age'] ?? student.age;
  return Response.ok(
    jsonEncode(student.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response _handleDelete(Request request, String id) {
  final Student? student = students.firstWhereOrNull((s) => s.id == id);
  if (student == null) {
    return Response.notFound('Student not found');
  }
  students.remove(student);
  return Response.ok('Student deleted', headers: {'Content-Type': 'text/plain'});
}

void main() async {
  final router = Router();

  router.get('/students', _handleGetAll);
  router.get('/students/<id>', _handleGetById);
  router.post('/students', _handleCreate);
  router.put('/students/<id>', _handleUpdate);
  router.patch('/students/<id>', _handlePatch);
  router.delete('/students/<id>', _handleDelete);

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler =
  Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');

}


// void main() async {
//   final router = Router();
//
//   router.get('/students', (Request request) {
//     print('GET /students route accessed');
//     return _handleGetAll(request);
//   });
//   router.get('/students/<id>', (Request request, String id) {
//     print('GET /students/$id route accessed');
//     return _handleGetById(request, id);
//   });
//   // ... other routes
//
//   final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);
//
//   final server = await io.serve(handler, 'localhost', 8080);
//
//   print('Server listening on port ${server.port}');
// }

