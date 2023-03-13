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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Sensors Reading"),
        backgroundColor: Colors.green,

      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Temperature :",style: TextStyle(fontSize: 24)),
                    Text("$temperature",style: TextStyle(fontSize: 24)),
                  ]
                ),
                SizedBox(
                  height: 30,
                ),

                Row(
                    children: [
                      Text("Humidity :",style: TextStyle(fontSize: 24)),
                      Text("$humidity",style: TextStyle(fontSize: 24)),
                    ]
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                    children: [
                      Text("Soil Moisture :",style: TextStyle(fontSize: 24)),
                      Text("$soilmoisture",style: TextStyle(fontSize: 24)),
                    ]
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Column(
                  children: [
                    SfRadialGauge(
                      axes: <RadialAxis>[RadialAxis(
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(widget: Container(child:
                            Text('$temperature',style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold))),
                                angle: 90,positionFactor: 0.5)],
                          pointers: <GaugePointer>[RangePointer(value: 30, pointerOffset: 50)]
                      ),
                      ],
                    ),
                    Text("Temperature",style:TextStyle(fontSize: 20),)
                  ],
                ),
                Column(
                  children: [
                    SfRadialGauge(
                      axes: <RadialAxis>[RadialAxis(
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(widget: Container(child:
                            Text('$temperature',style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold))),
                                angle: 90,positionFactor: 0.5)],
                          pointers: <GaugePointer>[RangePointer(value: 30, pointerOffset: 50)]
                      )],
                    ),
                    Text("Humidity",style:TextStyle(fontSize: 20),)

                  ],
                ),
                Column(
                  children: [
                    SfRadialGauge(
                      axes: <RadialAxis>[RadialAxis(
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(widget: Container(child:
                            Text('$temperature',style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold))),
                                angle: 90,positionFactor: 0.5)],
                          pointers: <GaugePointer>[RangePointer(value: 30, pointerOffset: 50)]
                      )],
                    ),
                    Text("Soil Moisture",style:TextStyle(fontSize: 20),)

                  ],
                ),

              ],
            ),
          ),
        ],
      )
    );
  }
}
