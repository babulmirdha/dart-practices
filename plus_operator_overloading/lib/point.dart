class Point {
  int x;
  int y;

  Point({required this.x, required this.y});

  operator +(Point o) {
    int newX = x + o.x;
    int newY = y + o.y;

    return Point(x: newX, y: newY);;
  }
}
