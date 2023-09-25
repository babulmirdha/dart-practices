class Book{

  String title;
  String author;
  num price;

  Book(this.title,this.author,this.price);

  @override
  String toString() {
    return "Title:$title,Author: $author, Price: $price";
  }
}