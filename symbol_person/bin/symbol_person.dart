import 'dart:core';
import 'dart:mirrors';
import '../lib/person.dart';


void checkIfClassAvailableInLibrary(Symbol libraryName, Symbol className) async {
  MirrorSystem mirrorSystem = currentMirrorSystem();
  LibraryMirror libMirror = mirrorSystem.findLibrary(libraryName);

  print("Found Library");
  print("checking...class details..");
  print("No of classes found is : ${libMirror.declarations.length}");
  libMirror.declarations.forEach((s, d) => print(s));

  if (libMirror.declarations.containsKey(className)) {
    print("class found..");
  }
}


void reflectInstanceMethods(Symbol libraryName, Symbol className) {
  MirrorSystem mirrorSystem = currentMirrorSystem();
  LibraryMirror libMirror = mirrorSystem.findLibrary(libraryName);

  print("Found Library");
  print("checking...class details..");
  print("No of classes found is : ${libMirror.declarations.length}");
  libMirror.declarations.forEach((s, d) => print(s));

  if (libMirror.declarations.containsKey(className)) {
    print("found class");
  }
  ClassMirror? classMirror = libMirror.declarations[className] as ClassMirror?;

  print("No of instance methods found is ${classMirror?.instanceMembers.length}");
  classMirror?.declarations.forEach((s, v) => print(s));
}



main() {
  //library name stored as Symbol
  Symbol librarySymbol = Symbol("person_lib");

  // class name stored as Symbol
  Symbol classPersonSymbol = Symbol("Person");

 checkIfClassAvailableInLibrary(librarySymbol, classPersonSymbol);

  reflectInstanceMethods(librarySymbol, classPersonSymbol);
}



