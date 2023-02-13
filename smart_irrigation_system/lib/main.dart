import 'package:flutter/material.dart';
import 'package:smart_irrigation_system/AutomaticPage.dart';
import 'package:smart_irrigation_system/ManualPage.dart';
import 'FirstPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'globalVariable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB11nTed8rQzyit31WpLVrWz39Yd5VFa4k",
          projectId: "smart-irrigation-system-fa56a",
          messagingSenderId: "824313233571",
          appId: "1:824313233571:web:dbfda510892154269cff16"));

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: returnScreen(),
    title: "Smart Irrigation System",
  ));
}

Widget? returnScreen() {
  if (isSelected == 1 && selectedMode == "Automatic") {
    return Automatic();
  } else if (isSelected == 1 && selectedMode == "Manual") {
    return Manual();
  }
  return FirstPage();
}
