import 'package:flutter/material.dart';

class PressBackButtonAgainToExitApp extends StatefulWidget {
  @override
  _PressBackButtonAgainToExitAppState createState() =>
      _PressBackButtonAgainToExitAppState();
}

class _PressBackButtonAgainToExitAppState
    extends State<PressBackButtonAgainToExitApp> {
  DateTime? _currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();

        if (_currentBackPressTime == null ||
            now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
          _currentBackPressTime = now;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back button again to exit'),
            ),
          );

          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("WillPopScope Demo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Press back button twice to exit app',
              ),
            ],
          ),
        ),
      ),
    );
  }
}