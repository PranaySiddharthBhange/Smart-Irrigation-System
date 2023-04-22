library globals.dart;

import 'package:flutter/cupertino.dart';

final myController = TextEditingController();

var isSelected;
//
// String? selectedCrop;
// String? selectedSoil;
String? selectedMode;
double? temperature;
double? humidity;
double? soilmoisture;
String? day;
String? city_name;
String? cityName;

var selectedSoil = 'Black Soil';
var selectedCrop;

String forBlack = 'Cotton';
String forAlluvial ='Cotton';
String forRedYellow='Ground Nut';
String forLaterite ='Cotton';
String forArid='Wheat';

// List of items in our soils
var Soils = [
  'Black Soil',
  'Alluvial Soil',
  'Red and Yellow Soil',
  'Laterite Soil',
  'Arid Soil',
];

// List of items for black soil
var forBlackList = [
  'Cotton',
  'Wheat',
  'Cereals',
  'Rice',
  'Jowar',
];
var forAlluvialList = [
  'Cotton',
  'Wheat',
  'Bajra',
  'Jute',
  'Maize',
];

var forRedYellowList = [
  'Ground Nut',
  'Potato',
  'Corn',
  'Ragi',
  'Pulses',
];

var forLateriteList = [
  'Cotton',
  'Wheat',
  'Rice',
  'Cashews',
  'Coffee',
];
var forAridList = [
  'Wheat',
  'Barley',
  'Maize',
  'Spices',
  'Coffee',
];
var modes = ['Automatic', 'Manual'];


var setDate=DateTime.now();

