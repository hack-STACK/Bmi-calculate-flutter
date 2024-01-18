import 'package:flutter/material.dart';

class BmiCalculate extends StatefulWidget {
  const BmiCalculate({Key? key});

  @override
  State<BmiCalculate> createState() => _BmiCalculateState();
}

class _BmiCalculateState extends State<BmiCalculate> {
  int currentIndex = 0;
  String result = "";

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bmi Calculator",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              const Text("Text your height in cm :"),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                controller: heightController,
                decoration: InputDecoration(
                  hintText: 'your height in cm',
                  filled: true,
                  fillColor: Theme.of(context).backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color),
              ),
              SizedBox(
                height: 20,
              ),
              const Text("Text your weight in KG :"),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                controller: weightController,
                decoration: InputDecoration(
                  hintText: 'your weight in KG',
                  filled: true,
                  fillColor: Theme.of(context).backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  radioButton(Icons.male, Colors.blue, 0),
                  radioButton(Icons.female, Colors.pink, 1),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    double h = double.tryParse(heightController.text) ?? 0.0;
                    double w = double.tryParse(weightController.text) ?? 0.0;
                    BmiCalculate(h, w, currentIndex);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text("Calculate"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    reset();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  child: const Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [Icon(Icons.refresh_sharp), Text("Reset")],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: const Text(
                  "Your BMI is :",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  " $result",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void reset() {
    setState(() {
      result = "";
      heightController.clear();
      weightController.clear();
    });
  }

  void BmiCalculate(double height, double weight, int index) {
    double heightInMeter = height / 100.roundToDouble();

    if (height <= 0) {
      setState(() {
        result = "Invalid height";
      });
      return;
    }

    double result1 = 0;

    if (index == 0) {
      result1 = weight / ((height / 100) * (height / 100) / 0.0001);
    } else if (index == 1) {
      result1 = (weight + 0.5) / ((height / 100) * (height / 100)/ 0.0001);
    } else {
      setState(() {
        result = "Select gender";
      });
      return;
    }
    String bmi = result1.toStringAsFixed(2);

    setState(() {
      if (result1 < 18.5) {
        bmi = "Underweight\nYour BMI is $bmi";
      } else if (result1 > 18.5 && result1 < 24.9) {
        bmi = "Normal\nYour BMI is $bmi";
      } else if (result1 > 24.9) {
        bmi = "Overweight\nYour BMI is $bmi";
      }
      result = bmi;
    });
  }

  void changeindex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget radioButton(IconData icon, Color color, int index) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        height: 50.0,
        child: TextButton(
          onPressed: () {
            changeindex(index);
          },
          style: TextButton.styleFrom(
            backgroundColor: currentIndex == index ? color : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Icon(
            icon,
            color: currentIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
