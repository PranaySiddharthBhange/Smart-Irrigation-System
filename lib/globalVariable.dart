library globals.dart;

var isSelected=0;

String? selectedCrop;
String? selectedSoil;
String? selectedMode;
double? temperature;
double? humidity;
double? soilmoisture;
String? day;

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