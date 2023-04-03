import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_irrigation_system/globalVariable.dart';
import 'dart:convert';
import 'Model.dart';

class CurrentWeatherPage extends StatefulWidget {
  CurrentWeatherPage({required city_name});


  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  late Weather _weather;

   @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Center(
              child: FutureBuilder(
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return  weatherBox(snapshot.data);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                future: getCurrentWeather(),
              ),

            ),
        );
  }
}

Widget weatherBox(Weather _weather) {

  return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
            margin: const EdgeInsets.all(10.0),
            child:
            Text("${_weather.temp}°C",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
            )
        ),
        Container(
            margin: const EdgeInsets.all(5.0),
            child: Text("${_weather.description}",style: TextStyle(fontSize: 25),)
        ),
        Container(
            margin: const EdgeInsets.all(5.0),
            child: Text("Feels:${_weather.feelsLike}°C")
        ),
        Container(
            margin: const EdgeInsets.all(5.0),
            child: Text("H:${_weather.high}°C L:${_weather.low}°C")
        ),
      ]

  );
}



Future<Weather> getCurrentWeather() async {
  print("$cityName");
  late Weather weather;
  city_name = cityName;
  String apiKey = "88bc515bbe23fdfc4e7c71fbbda1dd9f";
  var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city_name&appid=$apiKey&units=metric");

  final response = await http.get(url);

  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  return weather;
}