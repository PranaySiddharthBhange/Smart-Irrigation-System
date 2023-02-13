import 'package:flutter/material.dart';
import 'AutomaticPage.dart';
import 'ManualPage.dart';
import 'globalVariable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Center(
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              SizedBox(
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
              SizedBox(
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
                        isSelected=1;
                        selectedMode = newValue!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child:TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        isSelected=1;
                      });
                      if(selectedMode=='Automatic'){
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>  Automatic()));
                        FirebaseFirestore.instance.collection("page").doc().set({'isSelected':'$isSelected'});
                      }

                      if(selectedMode=='Manual'){Navigator.push(context,MaterialPageRoute(builder: (context) =>  Manual()));
                      }
                      FirebaseFirestore.instance.collection("page").doc().set({'isSelected':'$isSelected'});
                    },
                    child: const Text('Next',style: TextStyle(fontSize: 20),),
                  ))
            ]),
          ),
        ));
  }
}