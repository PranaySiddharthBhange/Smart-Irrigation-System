import 'package:flutter/material.dart';

class Manual extends StatefulWidget {
  const Manual({Key? key}) : super(key: key);

  @override
  State<Manual> createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  Color statusColor = Colors.green;
  var status = 'ON';
  void changeColor() {
    if (statusColor == Colors.green) {
      statusColor = Colors.deepOrange;
      setState(() {
        status = 'OFF';
      });
    } else {
      statusColor = Colors.green;
      setState(() {
        status = 'ON';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Manual"),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();

            },
            child: const Text('Exit'),
          ),
          OutlinedButton(
            onPressed: () {},
            child: const Text('Switch to Automatic'),
          ),
          OutlinedButton(
            onPressed: () {
              changeColor();
            },
            child: Text(
              '$status',
              style: TextStyle(color: statusColor),
            ),
          ),
          Text("Motor Status : $status"),
          Text("Number of Days :"),
          Container(
            child: Text("Sensor Readings"),
          ),
          Container(
            child: Text("Water Usage"),
          ),
          Container(
            child: Text("History"),
          ),
          Container(
            child: Text("Weather Information"),
          )
        ],
      ),
    );
  }
}
