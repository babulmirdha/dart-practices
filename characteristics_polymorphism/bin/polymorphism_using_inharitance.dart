// Base class
class Animal {
  void makeSound() {
    print('Animal makes a sound');
  }
}

// Subclass 1
class Dog extends Animal {
  @override
  void makeSound() {
    print('Dog barks');
  }
}

// Subclass 2
class Cat extends Animal {
  @override
  void makeSound() {
    print('Cat meows');
  }
}

void main() {
  Animal animal = Animal();
  Animal dog = Dog();
  Animal cat = Cat();

  animal.makeSound(); // Output: Animal makes a sound
  dog.makeSound(); // Output: Dog barks
  cat.makeSound(); // Output: Cat meows
}
