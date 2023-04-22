import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_irrigation_system/AutomaticPage.dart';
import 'package:smart_irrigation_system/ManualPage.dart';
import 'firebase_functions.dart';
import 'globalVariable.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  DateTime? _currentBackPressTime;

  @override
  Widget CropSelection(String selectedSoil) {
    switch (selectedSoil) {
      case 'Black Soil':
        {
          return DropdownButton(
            value: forBlack,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: forBlackList.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                forBlack = newValue!;
                selectedCrop = forBlack;
              });
            },
          );
        }
      case 'Alluvial Soil':
        {
          return DropdownButton(
            value: forAlluvial,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: forAlluvialList.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                forAlluvial = newValue!;
                selectedCrop = forAlluvial;
              });
            },
          );
        }
      case 'Red and Yellow Soil':
        {
          return DropdownButton(
            value: forRedYellow,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: forRedYellowList.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                forRedYellow = newValue!;
                selectedCrop = forRedYellow;
              });
            },
          );
        }
      case 'Laterite Soil':
        {
          return DropdownButton(
            value: forLaterite,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: forLateriteList.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                forLaterite = newValue!;
                selectedCrop = forLaterite;
              });
            },
          );
        }
      case 'Arid Soil':
        {
          return DropdownButton(
            value: forArid,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: forAridList.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                forArid = newValue!;
                selectedCrop = forArid;
              });
            },
          );
        }
      default:
        {
          return const Text("Select Soil First");
        }
    }
  }

  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Database");
    ref.remove();

    DatabaseReference ref2 = FirebaseDatabase.instance.ref("History");

    ref2.remove();

    DatabaseReference ref4 = FirebaseDatabase.instance.ref("Readings");

    ref4.remove();

    DatabaseReference ref5 = FirebaseDatabase.instance.ref("startDate");

    ref5.remove();
  }

  final pageRef = FirebaseDatabase.instance.ref("Page");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();

        if (_currentBackPressTime == null ||
            now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
          _currentBackPressTime = now;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      child: Image.asset("assets/images/agriculture.png"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    // Container(
                    //   height: 50,
                    //   width: 200,
                    //   padding: const EdgeInsets.only(left: 16, right: 10),
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.black, width: 1.5),
                    //       borderRadius: BorderRadius.circular(20)),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton(
                    //       focusColor: Colors.white,
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(20)),
                    //       dropdownColor: Colors.white,
                    //       iconSize: 36,
                    //       isExpanded: false,
                    //       style: const TextStyle(
                    //           color: Colors.black, fontSize: 22),
                    //       hint: const Text("Select Crop"),
                    //       value: selectedCrop,
                    //       icon: const Icon(Icons.keyboard_arrow_down,
                    //           color: Colors.black, size: 27),
                    //       items: crops.map((String items) {
                    //         return DropdownMenuItem(
                    //           value: items,
                    //           child: Text(items),
                    //         );
                    //       }).toList(),
                    //       onChanged: (var newValue) {
                    //         setState(() {
                    //           selectedCrop = newValue!;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    // Container(
                    //   height: 50,
                    //   width: 200,
                    //   padding: const EdgeInsets.only(left: 16, right: 10),
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.black, width: 1.5),
                    //       borderRadius: BorderRadius.circular(20)),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton(
                    //       focusColor: Colors.white,
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(20)),
                    //       dropdownColor: Colors.white,
                    //       iconSize: 36,
                    //       isExpanded: false,
                    //       style: const TextStyle(
                    //           color: Colors.black, fontSize: 22),
                    //       hint: const Text("Select Soil"),
                    //       value: selectedSoil,
                    //       icon: const Icon(Icons.keyboard_arrow_down,
                    //           color: Colors.black, size: 27),
                    //       items: soils.map((String items) {
                    //         return DropdownMenuItem(
                    //           value: items,
                    //           child: Text(items),
                    //         );
                    //       }).toList(),
                    //       onChanged: (String? newValue) {
                    //         setState(() {
                    //           selectedSoil = newValue!;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),

                    const Text("Select Soil"),
                    DropdownButton(
                      value: selectedSoil,
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: Soils.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSoil = newValue!;
                        });
                      },
                    ),
                    Text("You Selected $selectedSoil"),
                    CropSelection(selectedSoil),
                    Text("You Selected $selectedCrop"),














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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          dropdownColor: Colors.white,
                          iconSize: 36,
                          isExpanded: false,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 22),
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
                          onPressed: () async {
                              print(DateTime.now().toString());

                            final setDateRef=FirebaseDatabase.instance.ref('Date');
                            await setDateRef.set(DateTime.now().toString());

                            final soilRef = FirebaseDatabase.instance.ref("soil");
                            await soilRef
                                .set(selectedSoil)
                                .then((value) {})
                                .onError((error, stackTrace) {
                              print(error.toString());
                            });

                            final cropRef = FirebaseDatabase.instance.ref("crop");
                            await cropRef
                                .set(selectedCrop)
                                .then((value) {})
                                .onError((error, stackTrace) {
                              print(error.toString());
                            });

                              final modeRef = FirebaseDatabase.instance.ref("soil");
                              await modeRef
                                  .set(selectedSoil)
                                  .then((value) {})
                                  .onError((error, stackTrace) {
                                print(error.toString());
                              });
                            if (selectedMode == "Automatic") {
                              final pageStatRef = FirebaseDatabase.instance.ref("Page");
                              await pageStatRef
                                  .set(1)
                                  .then((value) {})
                                  .onError((error, stackTrace) {
                                print(error.toString());
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                           AutomaticPage()));

                            }
                            if (selectedMode == "Manual") {
                              final pageStatRef = FirebaseDatabase.instance.ref("Page");
                              await pageStatRef
                                  .set(2)
                                  .then((value) {})
                                  .onError((error, stackTrace) {
                                print(error.toString());
                              });

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ManualPage()));

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
