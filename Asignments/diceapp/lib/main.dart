import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(DiceApp());
}

class DiceApp extends StatefulWidget {
  @override
  _DiceAppState createState() => _DiceAppState();
}

class _DiceAppState extends State<DiceApp> with SingleTickerProviderStateMixin {
  int _numDice = 1;
  List<int> _diceValues = [1];
  late AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0, end: pi * 1.515);

  void _rollDice() {
    setState(() {
      _diceValues = List.generate(_numDice, (index) => Random().nextInt(6) + 1);
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dice App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 20),
            Text('Select number of dice: $_numDice'),
            Slider(
              value: _numDice.toDouble(),
              min: 1,
              max: 6,
              divisions: 5,
              onChanged: (double value) {
                setState(() {
                  _numDice = value.toInt();
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _rollDice,
              child: Text('Roll Dice'),
            ),
            SizedBox(height: 20),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 16.0,
              children: _diceValues.map((value) {
                return RotationTransition(
                  turns: _tween.animate(_controller),
                  child: Image.asset(
                    'assets/dice$value.png',
                    width: 100,
                    height: 100,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}