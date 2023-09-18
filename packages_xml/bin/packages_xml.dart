import 'package:packages_xml/packages_xml.dart' as packages_xml;
import 'package:xml/xml.dart';
import 'dart:io';

void main(List<String> arguments) {

  final bookshelfXml = '''<?xml version="1.0"?>
    <bookshelf>
      <book>
        <title lang="en">Growing a Language</title>
        <price>29.99</price>
      </book>
      <book>
        <title lang="en">Learning XML</title>
        <price>39.95</price>
      </book>
      <price>132.00</price>
    </bookshelf>''';
  var document = XmlDocument.parse(bookshelfXml);

  //To write back the parsed XML document, simply call toString() or toXmlString(...) if you need more control:

  print(document.toString());
  print(document.toXmlString(pretty: true, indent: '\t'));

  //To read XML from a file use the dart:io library:

  // final file = new File('bookshelf.xml');
  //
  //  document = XmlDocument.parse(file.readAsStringSync());

}
