// Base class
class Duck {
  void quack() {
    print("Duck: Quack!");
  }

  void swim() {
    print("Duck: Swimming");
  }

  void display() {
    print("Duck: Displaying");
  }

  void fly() {
    print("Duck: Flying");
  }
}

// Subclass 1
class MallardDuck extends Duck {
  @override
  void display() {
    print("Mallard Duck: Displaying");
  }

  @override
  void fly() {
    print("Mallard Duck: Flying");
  }
}

// Subclass 2
class RedHeadDuck extends Duck {
  @override
  void display() {
    print("RedHead Duck: Displaying");
  }

  @override
  void fly() {
    print("RedHead Duck: Flying");
  }
}

void main() {
  Duck duck = Duck();
  duck.quack();
  duck.swim();
  duck.display();
  duck.fly();

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
}