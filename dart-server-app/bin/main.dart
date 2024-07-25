import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'student.dart';

// Extension method to add firstWhereOrNull to List
extension FirstWhereOrNullExtension<E> on List<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

 List<Student>? students;

 void loadStudents(){
  var file = File("assets/students.json");

  var content = file.readAsStringSync();

  var list = jsonDecode(content);


  students ??= [];

  for (var map in list) {
    students?.add(Student.fromJson(map));
  }
}

Response _handleGetAll(Request request) {
  return Response.ok(
    jsonEncode(students?.map((s) => s.toJson()).toList()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response _handleGetById(Request request, String id) {
  final Student? student = students?.firstWhereOrNull((s) => s.id == id);
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
  students?.add(student);
  return Response.ok(
    jsonEncode(student.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> _handleUpdate(Request request, String id) async {
  final payload = await request.readAsString();
  final data = jsonDecode(payload);
  final Student? student = students?.firstWhereOrNull((s) => s.id == id);
  if (student == null) {
    return Response.notFound('Student not found');
  }
  student.name = data['name'];
  student.cgpa = data['age'];
  return Response.ok(
    jsonEncode(student.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> _handlePatch(Request request, String id) async {
  final payload = await request.readAsString();
  final data = jsonDecode(payload);
  final Student? student = students?.firstWhereOrNull((s) => s.id == id);
  if (student == null) {
    return Response.notFound('Student not found');
  }
  student.name = data['name'] ?? student.name;
  student.cgpa = data['age'] ?? student.cgpa;
  return Response.ok(
    jsonEncode(student.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response _handleDelete(Request request, String id) {
  final Student? student = students?.firstWhereOrNull((s) => s.id == id);
  if (student == null) {
    return Response.notFound('Student not found');
  }
  students?.remove(student);
  return Response.ok('Student deleted', headers: {'Content-Type': 'text/plain'});
}

void main() async {

   loadStudents();

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