//main.dart

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int answer;
  late int rows;
  late int columns;
  late int totalBoxes;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    // Generate a random multiplication question
    int num1 = Random().nextInt(30) + 1; // Random number between 1 and 30
    int num2 = Random().nextInt(10) + 1; // Random number between 1 and 10
    answer = num1 * num2;
    rows = 3;
    columns = 10;
    totalBoxes = rows * columns;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Roulette Math Game"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Solve: $answer",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              padding: const EdgeInsets.all(16.0),
              itemCount: totalBoxes,
              itemBuilder: (context, index) {
                int displayNumber = (index % totalBoxes) + 1;
                return GestureDetector(
                  onTap: () {
                    if (displayNumber == answer % totalBoxes) {
                      _showSuccessDialog();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Try Again!"),
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "$displayNumber",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Congratulations!"),
        content: Text("You found the correct box!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _generateQuestion();
              });
            },
            child: Text("Play Again"),
          ),
        ],
      ),
    );
  }
}
