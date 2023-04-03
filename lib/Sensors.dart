import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:smart_irrigation_system/globalVariable.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MetersPage extends StatefulWidget {
  const MetersPage({Key? key}) : super(key: key);

  @override
  State<MetersPage> createState() => _MetersPageState();
}

class _MetersPageState extends State<MetersPage> {



  @override
  void initState() {
    readHUmidity();
    readTemp();
    readMoist();
    super.initState();
  }
  var data;
  var data2;
  var data3;





  Future<void> readHUmidity() async {


    final Humidity = FirebaseDatabase.instance.ref("Readings");

    final snapshot = await Humidity.child('Humidity').get();
    if (snapshot.exists) {
      print(snapshot.value);
      setState(() {
        data= snapshot.value;

      });

      print(data);

    } else {
      print('No data available.');
    }


  }
  Future<void> readTemp() async {

    final Temp = FirebaseDatabase.instance.ref("Readings");

    final snapshot3 = await Temp.child('Temperature').get();
    if (snapshot3.exists) {
      print(snapshot3.value);
      setState(() {
        data2= snapshot3.value;

      });

      print(data2);

    } else {
      print('No data available.');
    }


  }
  Future<void> readMoist() async {



    final Moist = FirebaseDatabase.instance.ref("Readings");

    final snapshot3 = await Moist.child('Soil Moisture').get();
    if (snapshot3.exists) {
      print(snapshot3.value);
      setState(() {
        data3= snapshot3.value;

      });

      print(data3);

    } else {
      print('No data available.');
    }

    switch(selectedCrop) {
      case 'Rice': {
          if(data3>=20){
            //off
          }
      }
      break;

      case 'Wheat': {
        if(data3>=12){
          //off
        }
      }
      break;

      case 'Maize': {
        if(data3>=20){
          //off
        }
      }
      break;
      case 'Soyabean': {
        if(data3>=13){
          //off
        }
      }
      break;
      case 'Corn': {
        if(data3>=15){
          //off
        }
      }
      break;








    }


  }

  @override
  Widget build(BuildContext context) {

    final ref = FirebaseDatabase.instance.ref("Readings");


    return Scaffold(
        appBar: AppBar(
          title: Text("Sensors Reading"),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild: Text("Loading"),
                  itemBuilder: (context,snapshot,animation,index){
                    return ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Container(
                          height: 60,
                          width: 350,
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(snapshot.child("Humidity").value.toString(),style:TextStyle(fontSize: 25),)),
                      // title: Text(snapshot.child("Humidity").value.toString()),
                    );
                  }),
            ),
            SizedBox(
              height: 50,
            ),
            // Column(
            //
            //   children: [
            //     Container(
            //       height: 60,
            //         width: 350,
            //         padding: EdgeInsets.all(13),
            //         decoration: BoxDecoration(
            //             border: Border.all(color: Colors.black, width: 1.5),
            //             borderRadius: BorderRadius.circular(20)),
            //         child: Text("Humidity : $data %",style:TextStyle(fontSize: 25),)),
            //     SizedBox(
            //       height: 30,
            //     ),
            //     Container(
            //         height: 60,
            //         width: 350,
            //         padding: EdgeInsets.all(13),
            //         decoration: BoxDecoration(
            //             border: Border.all(color: Colors.black, width: 1.5),
            //             borderRadius: BorderRadius.circular(20)),
            //         child: Text("Temperature : $data3 deg ",style:TextStyle(fontSize: 25),)),
            //     SizedBox(
            //       height: 30,
            //     ),
            //     Container(
            //         height: 60,
            //         width: 350,
            //         padding: EdgeInsets.all(13),
            //         decoration: BoxDecoration(
            //             border: Border.all(color: Colors.black, width: 1.5),
            //             borderRadius: BorderRadius.circular(20)),
            //         child: Text("Soil Moisture : $data2 %",style:TextStyle(fontSize: 25),)),
            //
            //   ],
            // ),










            // SizedBox(
            //   height: 30,
            // ),
            //
            //
            //
            //
            // Expanded(
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.vertical,
            //     child: Column(
            //       children: [
            //         Column(
            //           children: [
            //             SfRadialGauge(
            //               axes: <RadialAxis>[
            //                 RadialAxis(annotations: <GaugeAnnotation>[
            //                   GaugeAnnotation(
            //                       widget: Container(
            //                           child: Text('$data %',
            //                               style: TextStyle(
            //                                   fontSize: 25,
            //                                   fontWeight: FontWeight.bold))),
            //                       angle: 90,
            //                       positionFactor: 0.5)
            //                 ], pointers: <GaugePointer>[
            //                   RangePointer(value:data, pointerOffset: 50)
            //                 ]),
            //               ],
            //             ),
            //             Text(
            //               "Humidity",
            //               style: TextStyle(fontSize: 20),
            //             )
            //           ],
            //         ),
            //         Column(
            //           children: [
            //             SfRadialGauge(
            //               axes: <RadialAxis>[
            //                 RadialAxis(annotations: <GaugeAnnotation>[
            //                   GaugeAnnotation(
            //                       widget: Container(
            //                           child: Text('$data2 deg',
            //                               style: TextStyle(
            //                                   fontSize: 25,
            //                                   fontWeight: FontWeight.bold))),
            //                       angle: 90,
            //                       positionFactor: 0.5)
            //                 ], pointers: <GaugePointer>[
            //                   RangePointer(value:data2, pointerOffset: 50)
            //                 ]),
            //               ],
            //             ),
            //             Text(
            //               "Temperature",
            //               style: TextStyle(fontSize: 20),
            //             )
            //           ],
            //         ),
            //         Column(
            //           children: [
            //             SfRadialGauge(
            //               axes: <RadialAxis>[
            //                 RadialAxis(annotations: <GaugeAnnotation>[
            //                   GaugeAnnotation(
            //                       widget: Container(
            //                           child: Text('$data3 %',
            //                               style: TextStyle(
            //                                   fontSize: 25,
            //                                   fontWeight: FontWeight.bold))),
            //                       angle: 90,
            //                       positionFactor: 0.5)
            //                 ], pointers: <GaugePointer>[
            //                   RangePointer(value:data3, pointerOffset: 50)
            //                 ]),
            //               ],
            //             ),
            //             Text(
            //               "Soil Moisture",
            //               style: TextStyle(fontSize: 20),
            //             )
            //           ],
            //         ),
            //
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
