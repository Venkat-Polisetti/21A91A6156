import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TemperatureConverterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _convertedTemperature = '';
  String _conversionType = 'Celsius to Fahrenheit';

  void _convertTemperature() {
    double inputTemperature = double.tryParse(_controller.text) ?? 0;
    double outputTemperature;

    if (_conversionType == 'Celsius to Fahrenheit') {
      outputTemperature = (inputTemperature * 9 / 5) + 32;
    } else {
      outputTemperature = (inputTemperature - 32) * 5 / 9;
    }

    setState(() {
      _convertedTemperature = outputTemperature.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text('Temperature Converter')),
          backgroundColor: Colors.purpleAccent
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: _conversionType,
              onChanged: (String? newValue) {
                setState(() {
                  _conversionType = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Conversion Type',
                labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              items: <String>[
                'Celsius to Fahrenheit',
                'Fahrenheit to Celsius'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _convertTemperature,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Convert'),
            ),
            SizedBox(height: 24),
            Text(
              'Converted Temperature: $_convertedTemperature',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}