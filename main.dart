import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill Splitter',
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Colors.black,
          secondary: Colors.yellow,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: Colors.yellow,
          thumbColor: Colors.yellow,
        ),
      ),
      home: BillSplitter(),
    );
  }
}

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _numberOfPeople = 1;
  double _billAmount = 0.0;
  double _tipPercentage = 0.0;

  void _setBillAmount(String value) {
    try {
      final amount = double.parse(value);
      setState(() {
        _billAmount = amount;
      });
    } catch (e) {}
  }

  void _setTipPercentage(double value) {
    setState(() {
      _tipPercentage = value;
    });
  }

  void _setNumberOfPeople(bool increment) {
    setState(() {
      if (increment) {
        _numberOfPeople++;
      } else {
        if (_numberOfPeople > 1) {
          _numberOfPeople--;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalTip = _billAmount * _tipPercentage / 100;
    double totalPerPerson = (_billAmount + totalTip) / _numberOfPeople;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Bill Splitter')),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                'Each person pays: \n\$${totalPerPerson.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.attach_money),
                labelText: 'Total Bill Amount',
                errorText: _billAmount <= 0 ? 'Please enter a valid amount' : null,
              ),
              onChanged: (String value) {
                _setBillAmount(value);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Split', style: TextStyle(fontSize: 18.0)),
                Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: () => _setNumberOfPeople(false),
                      child: Icon(Icons.remove),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.yellow),
                      ),
                    ),
                    Text('$_numberOfPeople', style: TextStyle(fontSize: 18.0)),
                    TextButton(
                      onPressed: () => _setNumberOfPeople(true),
                      child: Icon(Icons.add),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.yellow),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Tip', style: TextStyle(fontSize: 18.0)),
                Text('${_tipPercentage.toStringAsFixed(0)}%', style: TextStyle(fontSize: 18.0)),
              ],
            ),
            Slider(
              min: 0,
              max: 100,
              divisions: 20,
              value: _tipPercentage,
              onChanged: (double value) {
                _setTipPercentage(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}