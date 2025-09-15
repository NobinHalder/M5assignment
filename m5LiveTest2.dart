// Parent class
class Person {
  String name;

  Person(this.name);
}

// Child class
class Teacher extends Person {
  String subject;

  Teacher(String name, this.subject) : super(name);
}

void main() {
  // Create Teacher object
  Teacher t1 = Teacher("Rahim", "Mathematics");

  // Print both properties
  print("Name: ${t1.name}");
  print("Subject: ${t1.subject}");
}
