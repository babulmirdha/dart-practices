import 'dart:io';

void readFileUsingAwaitAsync() async {
  final file = File('assets/my_file.text');

  if (await file.exists()) {
    final contents = await file.readAsString();
    print(contents);
  } else {
    print('File does not exist');
  }
}

readFileUsingCallBack(){

  // try{
    var file = File("assets/my_file_x.text");
    file.readAsString().then((value) => print(value));
  // }
  // on PathNotFoundException{
  //   print("file path not found");
  // } on Exception catch (e){
  //   print(e);
  // }
  // catch(e){
  //   print(e);
  // }


}


main(){

  readFileUsingCallBack();

}