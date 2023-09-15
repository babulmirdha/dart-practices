import 'dart:core';
import 'dart:mirrors';
import '../lib/person.dart';

main() {
  //library name stored as Symbol
  Symbol librarySymbol = Symbol("person_lib");

  // class name stored as Symbol
  Symbol classPersonSymbol = Symbol("Person");

  MirrorSystem mirrorSystem = currentMirrorSystem();

  LibraryMirror libMirror = mirrorSystem.findLibrary(librarySymbol);

  print("No of classes found is : ${libMirror.declarations.length}");

  libMirror.declarations.forEach((s, d) => print("s:$s, d.qualifiedName:${d.qualifiedName}"));

  // searches Foo class in foo_lib library
  if (libMirror.declarations.containsKey(classPersonSymbol))
    {
        print("class found..");
    }
}



