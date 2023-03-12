import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      title: 'Counter App',
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter1 = 0;
  int _counter2 = 0;
  int _counter3 = 0;

  void _incrementCounter(int counterIndex) {
    setState(() {
      if (counterIndex == 1) {
        _counter1++;
        _showSnackBar('Counter 1 incremented');
      } else if (counterIndex == 2) {
        _counter2++;
        _showSnackBar('Counter 2 incremented');
      } else {
        _counter3++;
        _showSnackBar('Counter 3 incremented');
      }
    });
  }

  void _decrementCounter(int counterIndex) {
    setState(() {
      if (counterIndex == 1) {
        if (_counter1 > 0) {
          _counter1--;
          _showSnackBar('Counter 1 decremented');
        }
      } else if (counterIndex == 2) {
        if (_counter2 > 0) {
          _counter2--;
          _showSnackBar('Counter 2 decremented');
        }
      } else {
        if (_counter3 > 0) {
          _counter3--;
          _showSnackBar('Counter 3 decremented');
        }
      }
    });
  }

  void _resetCounters() {
    setState(() {
      _counter1 = 0;
      _counter2 = 0;
      _counter3 = 0;
      _showSnackBar('Counters reset');
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds:120),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('image/image.jpg'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCounter(_counter1, 1),
                _buildCounter(_counter2, 2),
                _buildCounter(_counter3, 3),
              ],
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: _resetCounters,
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(int counter, int counterIndex) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => _decrementCounter(counterIndex),
          icon: const Icon(Icons.remove_circle),
        ),
        Text(
          '$counter',
          style: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () => _incrementCounter(counterIndex),
          icon: Icon(Icons.add_box_rounded),
        ),
        SizedBox(height: 20.0),
        Text('Counter $counterIndex'),
      ],
    );
  }
}
