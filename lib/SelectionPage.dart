import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_irrigation_system/AutomaticPage.dart';
import 'package:smart_irrigation_system/ManualPage.dart';
import 'globalVariable.dart';


class SelectionPage extends StatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);

  @override
  State<SelectionPage> createState() => _SelectionPageState();

}

class _SelectionPageState extends State<SelectionPage> {

  DateTime? _currentBackPressTime;

  @override
  void initState() {
    super.initState();
  }

  final databaseRef =FirebaseDatabase.instance.ref("Database");
  final pageRef =FirebaseDatabase.instance.ref("Page");

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
            title: const Center(
                child: Text(
              "AgroTech",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            )),
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green,
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Center(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  height: 150,
                  child: Image.asset("assets/images/agriculture.png"),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 200,
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      focusColor: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      dropdownColor: Colors.white,
                      iconSize: 36,
                      isExpanded: false,
                      style: const TextStyle(color: Colors.black, fontSize: 22),
                      hint: const Text("Select Crop"),
                      value: selectedCrop,
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.black, size: 27),
                      items: crops.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (var newValue) {
                        setState(() {
                          selectedCrop = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 200,
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      focusColor: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      dropdownColor: Colors.white,
                      iconSize: 36,
                      isExpanded: false,
                      style: const TextStyle(color: Colors.black, fontSize: 22),
                      hint: const Text("Select Soil"),
                      value: selectedSoil,
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.black, size: 27),
                      items: soils.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSoil = newValue!;

                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 200,
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      focusColor: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      dropdownColor: Colors.white,
                      iconSize: 36,
                      isExpanded: false,
                      style: const TextStyle(color: Colors.black, fontSize: 22),
                      hint: const Text("Select Mode"),
                      value: selectedMode,
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.black, size: 27),
                      items: modes.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          isSelected = 1;
                          selectedMode = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                          if(selectedMode=="Automatic"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AutomaticPage()));
                            databaseRef.child("Selection").set({
                              'Mode' : selectedMode,
                              'Crop' : selectedCrop,
                              'Soil' : selectedSoil
                            }).then((value){

                            }).onError((error, stackTrace) {
                              print("NOT Added");
                            });
                            pageRef.set(1);
                          }
                          if(selectedMode=="Manual"){

                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ManualPage()));
                            databaseRef.child("Selection").set({
                              'Mode' : selectedMode,
                              'Crop' : selectedCrop,
                              'Soil' : selectedSoil
                            }).then((value){

                            }).onError((error, stackTrace) {
                              print("NOT Added");
                            });
                            pageRef.set(2);

                          }
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 20),
                      ),
                    ))
              ]),
            ),
          )),
    );
  }
}
