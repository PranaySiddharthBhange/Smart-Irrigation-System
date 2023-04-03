library globals.dart;

import 'package:flutter/cupertino.dart';

final myController = TextEditingController();

var isSelected;

String? selectedCrop;
String? selectedSoil;
String? selectedMode;
double? temperature;
double? humidity;
double? soilmoisture;
String? day;
String? city_name;
String? cityName;

var crops = [
  'Wheat',
  'Rice',
  'Maize',
  'Soyabean',
  'Corn',
  'Tomato',
  'Potato',
  'Onion',
  'Bean',
];
var soils = [
  'Black Soil',
  'Red Soil',
  'Brown Soil',
  'Sandy Soil',
  'Muddy Soil',
];
var modes = ['Automatic', 'Manual'];


