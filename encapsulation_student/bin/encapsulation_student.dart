import 'package:encapsulation_student/encapsulation_student.dart' as encapsulation_student;

class Student{

  String name = "";
  double cgpa = 0;

  String getName(){
    return name;
  }

  void setName(String value){
     name = value;
  }

  double getCgpa(){
    return cgpa;
  }


  void setCgpa(double value){

    if(value>0){
      cgpa = value;
    }

  }
}


void main(List<String> arguments) {

  var rahim = Student();

  print(rahim.getCgpa());
  rahim.setCgpa(3.14);
  print(rahim.getCgpa());
  rahim.setCgpa(-3.14);
  print(rahim.getCgpa());







}
