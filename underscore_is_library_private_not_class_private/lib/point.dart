class Point {
  int _x = 0;
  int _y = 0;

  Point({int x = 0, int y = 0}) {
    _x = x;
    _y = y;
  }

 int get x{
    return _x;
  }

  set x(int value){
    _x = value;
  }

  int get y{
    return _y;
  }

  set y(int value){
    _y = value;
  }


  show() {
    print('Point(x=$_x,y=$_y)');
  }
}

