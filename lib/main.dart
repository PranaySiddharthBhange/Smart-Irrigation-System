import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_irrigation_system/AutomaticPage.dart';
import 'package:smart_irrigation_system/firebase_functions.dart';
import 'SelectionPage.dart';
import 'ManualPage.dart';
import 'package:firebase_core/firebase_core.dart';

var pageState; //variable stores the value of page state fetched from database

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final ref = FirebaseDatabase.instance.ref("Page");

  final snapshot = await ref.child('').get();

  if (snapshot.exists) {
    pageState = snapshot.value;
  } else {
    print('No data available.');
  }
  getCurrentPage();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: returnScreen(),
    title: "AgroTech",
  ));
}

Widget? returnScreen() {
  if (pageState == 1) {
    return AutomaticPage();
  } else if (pageState == 2) {
    return ManualPage();
  } else if (pageState == 0) {
    return SelectionPage();
  }
}