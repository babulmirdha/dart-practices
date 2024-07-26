import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'student.dart';

List<Student>? students;

var studentFileName = "assets/students.json";

void loadStudents() {
  var file = File(studentFileName);

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
  // final Student? student = students?.firstWhereOrNull((s) => s.id == id);
  final Student? student = students?.where((s) => s.id == id).firstOrNull;

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
  final newStudent = Student.fromJson(data);

  final Student? oldStudent =
      students?.where((s) => s.id == newStudent.id).firstOrNull;

  if (oldStudent == null) {
    students?.add(newStudent);

    saveStudentListToJsonDb();

    return Response.ok(
      jsonEncode(newStudent.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  } else {
    // Student ID already taken
    return Response(
      409, // HTTP status code for Conflict
      body: jsonEncode({'error': 'Student ID already taken'}),
      headers: {'Content-Type': 'application/json'},
    );

  }
}

Future<void> saveStudentListToJsonDb() async {
  // Convert the list of Student objects to a JSON list
  List<Map<String, dynamic>> jsonList =
      students?.map((student) => student.toJson()).toList() ?? [];

  // Convert the JSON list to a JSON string
  String jsonString = jsonEncode(jsonList);

  var file = await File(studentFileName).writeAsString(
    jsonString,
    mode: FileMode.write, // This specifies that the content should be written
  );

  print(file.toString());
}

Future<Response> _handleUpdate(Request request, String id) async {
  final payload = await request.readAsString();
  final data = jsonDecode(payload);

  // final Student? student = students?.firstWhereOrNull((s) => s.id == id);

  final Student? student = students?.where((s) => s.id == id).firstOrNull;

  if (student == null) {
    return Response.notFound('Student not found');
  }

  student.name = data['name'];
  student.dept = data['dept'];
  student.cgpa = data['cgpa'];

  saveStudentListToJsonDb();

  return Response.ok(
    jsonEncode(student.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

Future<Response> _handlePatch(Request request, String id) async {
  final payload = await request.readAsString();
  final data = jsonDecode(payload);

  // final Student? student = students?.firstWhereOrNull((s) => s.id == id);

  final Student? student = students?.where((s) => s.id == id).firstOrNull;

  if (student == null) {
    return Response.notFound('Student not found');
  }
  student.name = data['name'] ?? student.name;
  student.dept = data['dept'] ?? student.dept;
  student.cgpa = data['cgpa'] ?? student.cgpa;

  saveStudentListToJsonDb();

  return Response.ok(
    jsonEncode(student.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response _handleDelete(Request request, String id) {
  // final Student? student = students?.firstWhereOrNull((s) => s.id == id);

  final Student? student = students?.where((s) => s.id == id).firstOrNull;

  if (student == null) {
    return Response.notFound('Student not found');
  }
  students?.remove(student);

  saveStudentListToJsonDb();

  return Response.ok('Student deleted',
      headers: {'Content-Type': 'text/plain'});
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
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
