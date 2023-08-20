class Person {
  String name = "";
  int age = 0;

  Person({String name = "Huy", int age = 10});

  void sayHello() {
    print("Hello, my name is ${this.name}.");
  }
}

Person a = Person(name: "huy", age: 10);
