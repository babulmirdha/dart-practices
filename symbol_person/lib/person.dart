library person_lib;
// Library name can be a symbol

class Person {
  final String _firstName;
  final String _lastName;

  Person(this._firstName, this._lastName);

  get fullName {
    return "$_firstName $_lastName";
  }

  void show(){
    print("Name: $fullName");
  }
}

class Teacher extends Person {
  final int _noOfPublications;

  Teacher(super.firstName, super.lastName, this._noOfPublications);

  @override
  void show(){
    print("Name: $fullName, No of Pubs: $_noOfPublications");
  }

}

class Student extends Person {
  final double _cgpa;

  Student(super.firstName, super.lastName, this._cgpa);

  @override
  void show(){
    print("Name: $fullName, CGPA: $_cgpa");
  }
}
