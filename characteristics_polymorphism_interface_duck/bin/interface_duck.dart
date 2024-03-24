// Base class
class Duck {


  void swim() {
    print("Duck: Swimming");
  }

  void display() {
    print("Duck: Displaying");
  }


}

abstract class Quackable{
  void quack();
}

abstract class Flyable{
  void fly();
}

// Subclass 1
class MallardDuck extends Duck implements Quackable, Flyable {
  @override
  void display() {
    print("Mallard Duck: Displaying");
  }

  @override
  void fly() {
    print("Mallard Duck: Flying");
  }

  @override
  void quack() {
    print("Mallard Duck: Quack");
  }
}

// Subclass 2
class RedHeadDuck extends Duck implements Quackable, Flyable{
  @override
  void display() {
    print("RedHead Duck: Displaying");
  }

  @override
  void fly() {
    print("RedHead Duck: Flying");
  }

  @override
  void quack() {
    print("RedHead Duck: Quack");
  }
}


// Subclass 3
class RubberDuck extends Duck implements Quackable, Flyable{
  @override
  void display() {
    print("Rubber Duck: Displaying");
  }

  @override
  void fly() {
    print("Rubber Duck: Flying");
  }

  @override
  void quack() {
    print("Rubber Duck: Squack");
  }
}


// Subclass 3
class DecoyDuck extends Duck implements Quackable{
  @override
  void display() {
    print("Decoy Duck: Displaying");
  }


  @override
  void quack() {
    print("Decoy Duck: Quack");
  }
}

void main() {
  Duck duck = Duck();
  duck.swim();
  duck.display();

  MallardDuck mallardDuck = MallardDuck();
  mallardDuck.quack();
  mallardDuck.swim();
  mallardDuck.display();
  mallardDuck.fly();

  RedHeadDuck redHeadDuck = RedHeadDuck();
  redHeadDuck.quack();
  redHeadDuck.swim();
  redHeadDuck.display();
  redHeadDuck.fly();


  RubberDuck rubberDuck = RubberDuck();
  rubberDuck.quack();
  rubberDuck.swim();
  rubberDuck.display();
  rubberDuck.fly();

  DecoyDuck decoyDuck = DecoyDuck();
  decoyDuck.quack();
  decoyDuck.swim();
  decoyDuck.display();

}