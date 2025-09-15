class Student {
  String name;
  int roll;

  // Constructor
  Student(this.name, this.roll);

  // Method to display student info
  void displayInfo() {
    print("Name: $name");
    print("Roll: $roll");
  }
}

void main() {
  // Creating one student object
  Student s1 = Student("Rahim", 101);

  // Displaying details
  s1.displayInfo();
}
