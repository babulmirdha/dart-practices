class Student {
  String id;
  String name;
  String dept;
  double cgpa;

  Student({required this.id, required this.name, required this.dept, required this.cgpa});

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'dept': dept, 'cgpa': cgpa};

  static Student fromJson(Map<String, dynamic> json) =>
      Student(id: json['id'], name: json['name'], dept: json['dept'], cgpa: json['cgpa']);
}