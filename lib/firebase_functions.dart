import 'dart:math';

import 'package:firebase_database/firebase_database.dart';

//Function Fetching the page State
var state;

 Future<int> readPage() async {

  final pageState = FirebaseDatabase.instance.ref("Page");

  await pageState.child('').get().then((value) {
    state= value.value;

    print("Page Status Successfully Fetched and page state is $state");

  }).onError((error, stackTrace) {
    print("Failed to fetch Page Status");
    print(error.toString());
  });

  print(state);
  return state;

}

//Function to get number of days past


var differenceInDays;
var startDate;


 // Future<int> days() async{
 //
 //   final days = FirebaseDatabase.instance.ref("Date");
 //   await days.child('').get().then((value) {
 //     startDate=value.value;
 //
 //   }).onError((error, stackTrace){
 //     print("Failed to fetch start date");
 //     print(error.toString());
 //   });
 //
 //   DateTime dateTimeCreatedAt = DateTime.parse('$startDate');
 //   DateTime dateTimeNow = DateTime.now();
 //   differenceInDays = dateTimeNow.difference(dateTimeCreatedAt).inDays;
 //   print(differenceInDays);
 //   return differenceInDays;
 //   // return differenceInDays;
 // }

//function to fetch selected mode
var modeSelected;

 Future<String> mode()async{
   final modeRef = FirebaseDatabase.instance.ref("mode");
   await modeRef.child('').get().then((value) {
     modeSelected=value.value;

   }).onError((error, stackTrace){
     print("Failed to fetch start date");
     print(error.toString());
   });

   return modeSelected;
 }

 //function to fetch motor status
var motorStatus;

 Future<String> motorState() async {
   final motorRef = FirebaseDatabase.instance.ref("status");
   await motorRef.child('').get().then((value) {
     motorStatus=value.value;

   }).onError((error, stackTrace){
     print("Failed to fetch start date");
     print(error.toString());
   });

   return motorStatus;
 }

 //function to fetch crop
var cropSel;

Future<String> cropSelected() async {
  final cropRef = FirebaseDatabase.instance.ref("crop");
  await cropRef.child('').get().then((value) {
    cropSel=value.value;

  }).onError((error, stackTrace){
    print("Failed to fetch start date");
    print(error.toString());
  });
  return cropSel;
}

//function to fetch soil
var soilSel;

Future<String> soilSelected() async {
  final soilRef = FirebaseDatabase.instance.ref("soil");
  await soilRef.child('').get().then((value) {
    soilSel=value.value;

  }).onError((error, stackTrace){
    print("Failed to fetch start date");
    print(error.toString());
  });

  return soilSel;
}

//fetch humidity
var fetchHumidity;
Future<void> readHumidity() async {


  final Humidity = FirebaseDatabase.instance.ref("humidity");

  await Humidity.child('').get().then((value) {
    print("Fetched Humidity Value");

    fetchHumidity=value.value;
  }).onError((error, stackTrace){
    print("Error Occured in Fetching humidity");
    print(error.toString());

  });

  print(fetchHumidity);

}

//Set Random value functions

void setRandom(){

  var intValue = Random().nextInt(15) + 75; // Value is >= 75 and < 90.
  final Humidity = FirebaseDatabase.instance.ref("humidity");
   Humidity.set(intValue);
   readHumidity();
   print("Fetched VAlue is $fetchHumidity");

  print(intValue);
   }