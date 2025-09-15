// Abstract class
abstract class Shape {
  // Abstract method
  double area();

  // Getter for area
  double get getArea => area();

  // Setter for area (not usual, but as per requirement)
  set setArea(double value);
}

// Subclass Circle
class Circle extends Shape {
  double radius;

  Circle(this.radius);

  // Implement abstract method
  @override
  double area() {
    return 3.1416 * radius * radius;
  }

  // Implement setter
  @override
  set setArea(double value) {
    // From area, recalculate radius
    radius = (value / 3.1416).sqrt();
  }
}

extension on double {
  double sqrt() => Math.sqrt(this); // need dart:math
}

void main() {
  Circle c = Circle(5);

  // Print area using method
  print("Area (method): ${c.area()}");

  // Print area using getter
  print("Area (getter): ${c.getArea}");
}
