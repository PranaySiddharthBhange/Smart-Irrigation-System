import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:smart_irrigation_system/globalVariable.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'firebase_functions.dart';

class MetersPage extends StatefulWidget {
  const MetersPage({Key? key}) : super(key: key);

  @override
  State<MetersPage> createState() => _MetersPageState();
}

class _MetersPageState extends State<MetersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sensors Reading "),
          backgroundColor: Colors.green,
        ),
        body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseDatabase.instance.ref('humidity').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                      var databaseSnapshot = databaseEvent.snapshot; // 👈 Get the DataSnapshot from the DatabaseEvent
                      print('Snapshot: ${databaseSnapshot.value}');
                      return Text("Humidity: ${databaseSnapshot.value.toString()}",style: TextStyle(color: Colors.black),);
                    } else {
                      return CircularProgressIndicator();
                    }      }
              ),
              StreamBuilder(
                  stream: FirebaseDatabase.instance.ref('temperature').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                      var databaseSnapshot = databaseEvent.snapshot; // 👈 Get the DataSnapshot from the DatabaseEvent
                      print('Snapshot: ${databaseSnapshot.value}');
                      return Text("temperature: ${databaseSnapshot.value.toString()}",style: TextStyle(color: Colors.black),);
                    } else {
                      return CircularProgressIndicator();
                    }      }
              ),
              StreamBuilder(
                  stream: FirebaseDatabase.instance.ref('moisture').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                      var databaseSnapshot = databaseEvent.snapshot; // 👈 Get the DataSnapshot from the DatabaseEvent
                      print('Snapshot: ${databaseSnapshot.value}');
                      return Text("moisture: ${databaseSnapshot.value.toString()}",style: TextStyle(color: Colors.black),);
                    } else {
                      return CircularProgressIndicator();
                    }      }
              ),

              Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseDatabase.instance.ref('humidity').onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                          var databaseSnapshot = databaseEvent.snapshot;
                          // Double val=databaseSnapshot.value.runtimeType()
                          // 👈 Get the DataSnapshot from the DatabaseEvent
                          print('Snapshot: ${databaseSnapshot.value}');
                          return SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: Text('Humidity',
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold))),
                                    angle: 90,
                                    positionFactor: 0.5)
                              ], pointers: <GaugePointer>[
                                RangePointer(value:databaseSnapshot.value as double, pointerOffset: 50)
                              ]),
                            ],
                          );
                        } else {
                          return CircularProgressIndicator();
                        }      }
                  ),
                  StreamBuilder(
                      stream: FirebaseDatabase.instance.ref('temperature').onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                          var databaseSnapshot = databaseEvent.snapshot;
                          // Double val=databaseSnapshot.value.runtimeType()
                          // 👈 Get the DataSnapshot from the DatabaseEvent
                          print('Snapshot: ${databaseSnapshot.value}');
                          return SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: Text('Temperature',
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold))),
                                    angle: 90,
                                    positionFactor: 0.5)
                              ], pointers: <GaugePointer>[
                                RangePointer(value:databaseSnapshot.value as double, pointerOffset: 50)
                              ]),
                            ],
                          );
                        } else {
                          return CircularProgressIndicator();
                        }      }
                  ),
                  StreamBuilder(
                      stream: FirebaseDatabase.instance.ref('moisture').onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                          var databaseSnapshot = databaseEvent.snapshot;
                          // Double val=databaseSnapshot.value.runtimeType()
                          // 👈 Get the DataSnapshot from the DatabaseEvent
                          print('Snapshot: ${databaseSnapshot.value}');
                          return SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: Text('Moisture',
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold))),
                                    angle: 90,
                                    positionFactor: 0.5)
                              ], pointers: <GaugePointer>[
                                RangePointer(value:databaseSnapshot.value as double, pointerOffset: 50)
                              ]),
                            ],
                          );
                        } else {
                          return CircularProgressIndicator();
                        }      }
                  ),
                ],
              ),





            ],
          ),
        ));
  }
}

// Expanded(
// child: SingleChildScrollView(
// scrollDirection: Axis.vertical,
// child: Column(
// children: [
// Column(
// children: [
// SfRadialGauge(
// axes: <RadialAxis>[
// RadialAxis(annotations: <GaugeAnnotation>[
// GaugeAnnotation(
// widget: Container(
// child: Text('Humidity',
// style: TextStyle(
// fontSize: 25,
// fontWeight: FontWeight.bold))),
// angle: 90,
// positionFactor: 0.5)
// ], pointers: <GaugePointer>[
// RangePointer(value:34, pointerOffset: 50)
// ]),
// ],
// ),
// Text(
// "Humidity",
// style: TextStyle(fontSize: 20),
// )
// ],
// ),
// Column(
// children: [
// SfRadialGauge(
// axes: <RadialAxis>[
// RadialAxis(annotations: <GaugeAnnotation>[
// GaugeAnnotation(
// widget: Container(
// child: Text('Temperature',
// style: TextStyle(
// fontSize: 25,
// fontWeight: FontWeight.bold))),
// angle: 90,
// positionFactor: 0.5)
// ], pointers: <GaugePointer>[
// RangePointer(value:23, pointerOffset: 50)
// ]),
// ],
// ),
// Text(
// "Temperature",
// style: TextStyle(fontSize: 20),
// )
// ],
// ),
// Column(
// children: [
// SfRadialGauge(
// axes: <RadialAxis>[
// RadialAxis(annotations: <GaugeAnnotation>[
// GaugeAnnotation(
// widget: Container(
// child: Text('Moisture',
// style: TextStyle(
// fontSize: 25,
// fontWeight: FontWeight.bold))),
// angle: 90,
// positionFactor: 0.5)
// ], pointers: <GaugePointer>[
// RangePointer(value:23, pointerOffset: 50)
// ]),
// ],
// ),
// Text(
// "Soil Moisture",
// style: TextStyle(fontSize: 20),
// )
// ],
// ),
//
// ],
// ),
// ),
// ),
