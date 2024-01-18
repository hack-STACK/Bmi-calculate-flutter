import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BmiCalculate(),
    );
  }
}

class BmiCalculate extends StatefulWidget {
  const BmiCalculate({super.key});

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
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Bmi Calculator",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.0,
          backgroundColor: Colors.red,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    radioButton("man", Colors.blue, 0),
                    radioButton("woman", Colors.pink, 1),
                    // Add more radio buttons as needed
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Text your height in cm :"),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  controller:  heightController,
                  decoration: InputDecoration(
                      hintText: 'your height in cm',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Text your weigth in KG :"),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  controller: weightController,
                  decoration: InputDecoration(
                      hintText: 'your height in cm',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      double h = double.parse(heightController.value.text);
                      double w = double.parse(weightController.value.text);
                      BmiCalculate(h, w, currentIndex);
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue),
                    child: Text("calculate"),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  child: const Text(
                    "Your BMI is :",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),

                 Container(
                  width: double.infinity,
                  child:  Text(
                    " $result",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
    void BmiCalculate (double height, double weight, int index){
      double result1 = 0;
      if (index == 0 ){
        result1 = (weight / (height * height / 10000));
      } else if(index == 1 ){
        result1 = (weight + 0.5) / (height * height / 10000);
      }
    String bmi = result1.toStringAsFixed(2);
    setState(() {
      result = bmi;
    });
  }

  void changeindex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget radioButton(String values, Color color, int index) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        height: 80.0,
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
          child: Text(
            values,
            style: TextStyle(
              color: currentIndex == index ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
