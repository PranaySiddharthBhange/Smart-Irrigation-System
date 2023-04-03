import 'package:flutter/material.dart';
import 'package:smart_irrigation_system/currentWeather.dart';

import 'globalVariable.dart';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);


  @override
  State<Weather> createState() => _WeatherState();

}

class _WeatherState extends State<Weather> {
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Weather Information"),
        backgroundColor: Colors.green,
      ),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: myController,
              autocorrect: true,
              autofillHints: const [AutofillHints.addressCity],
              showCursor: true,
              decoration: const InputDecoration(
                hintText: "Enter City Name",

              ),
            ),

          ),

          TextButton(

              onPressed: (){
            setState(() {
              cityName = myController.text;
            });
            print(myController.text);
            Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentWeatherPage(city_name: myController.text),));
          }, child: Text("Search"))
        ],
      )

     // body: CurrentWeatherPage(),

    );
  }
}
