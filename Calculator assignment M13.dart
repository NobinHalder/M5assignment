import 'package:flutter/material.dart';

class BMIHome extends StatefulWidget {
  const BMIHome({super.key});

  @override
  State<BMIHome> createState() => _BMIHomeState();
}

class _BMIHomeState extends State<BMIHome> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  String weightUnit = "kg";
  String heightUnit = "cm";

  double bmi = 0;
  String bmiStatus = "";
  Color bmiColor = Colors.grey;

  // Convert weight to KG
  double convertWeight(double w) {
    if (weightUnit == "kg") return w;
    if (weightUnit == "lbs") return w * 0.453592;
    return w;
  }

  // Convert height to Meter
  double convertHeight(double h) {
    if (heightUnit == "cm") return h / 100;
    if (heightUnit == "meter") return h;
    if (heightUnit == "feet") return h * 0.3048;
    return h;
  }

  void calculateBMI() {
    final w = double.tryParse(weightController.text);
    final h = double.tryParse(heightController.text);

    if (w == null || h == null || w <= 0 || h <= 0) {
      setState(() {
        bmi = 0;
        bmiStatus = "Invalid input!";
        bmiColor = Colors.red;
      });
      return;
    }

    double weightKg = convertWeight(w);
    double heightM = convertHeight(h);

    double result = weightKg / (heightM * heightM);

    setState(() {
      bmi = result;

      if (bmi < 18.5) {
        bmiStatus = "Underweight";
        bmiColor = Colors.blue;
      } else if (bmi < 25) {
        bmiStatus = "Normal";
        bmiColor = Colors.green;
      } else if (bmi < 30) {
        bmiStatus = "Overweight";
        bmiColor = Colors.orange;
      } else {
        bmiStatus = "Obese";
        bmiColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Weight Input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Weight",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: weightUnit,
                  items: const [
                    DropdownMenuItem(value: "kg", child: Text("KG")),
                    DropdownMenuItem(value: "lbs", child: Text("LBS")),
                  ],
                  onChanged: (v) => setState(() => weightUnit = v!),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Height Input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Height",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: heightUnit,
                  items: const [
                    DropdownMenuItem(value: "cm", child: Text("CM")),
                    DropdownMenuItem(value: "meter", child: Text("Meter")),
                    DropdownMenuItem(value: "feet", child: Text("Feet")),
                  ],
                  onChanged: (v) => setState(() => heightUnit = v!),
                ),
              ],
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                "Calculate BMI",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

            const SizedBox(height: 25),

            // Result
            if (bmi > 0)
              Column(
                children: [
                  Text(
                    "BMI: ${bmi.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: bmiColor),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    bmiStatus,
                    style: TextStyle(fontSize: 22, color: bmiColor),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
