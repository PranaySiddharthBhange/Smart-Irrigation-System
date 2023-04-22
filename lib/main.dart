import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_irrigation_system/AutomaticPage.dart';
import 'SelectionPage.dart';
import 'ManualPage.dart';
import 'package:firebase_core/firebase_core.dart';

//variable that store the fetched value of page number from database
var state;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCeCrg7IO-BaFt4D9wbfcb3nIQzyGmH1HI",
            authDomain: "agrotech-d6e76.firebaseapp.com",
            databaseURL: "https://agrotech-d6e76-default-rtdb.firebaseio.com",
            projectId: "agrotech-d6e76",
            storageBucket: "agrotech-d6e76.appspot.com",
            messagingSenderId: "998053960418",
            appId: "1:998053960418:web:5277911e3f09cbedbddcbb",
            measurementId: "G-E16TDEF9SN"));
  } else {
    await Firebase.initializeApp();
  }
  await Firebase.initializeApp();


  final pageState = FirebaseDatabase.instance.ref("Page");

  await pageState.get().then((value) {
    state= value.value;

    print("Page Status Successfully Fetched and page state is $state");

  }).onError((error, stackTrace) {
    print("Failed to fetch Page Status");
    print(error.toString());
  });

  // var pageNumber = await readPage();


  print("inside main");

  Widget? returnScreen() {
    if (state == 1) {
      return AutomaticPage();
    } else if (state == 2) {
      return ManualPage();
    } else if (state == 0) {
      return SelectionPage();
    }
    return null;
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: returnScreen(),
    title: "AgroTech",
  ));
}
