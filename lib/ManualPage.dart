import 'package:flutter/material.dart';
import 'package:smart_irrigation_system/AutomaticPage.dart';
import 'package:smart_irrigation_system/FirstPage.dart';
import 'History.dart';
import 'Sensors.dart';
import 'Weather.dart';
import 'globalVariable.dart';

class Manual extends StatefulWidget {
  const Manual({Key? key}) : super(key: key);

  @override
  State<Manual> createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  Color statusColor = Colors.green;
  var status = 'ON';
  void changeColor() {
    if (statusColor == Colors.green) {
      statusColor = Colors.deepOrange;
      setState(() {
        status = 'OFF';
      });
    } else {
      statusColor = Colors.green;
      setState(() {
        status = 'ON';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manual Mode"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                    height: 180,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20)),
                    child:TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {

                      },
                      child: Row(
                        children: [
                          Image.asset("assets/images/plant.png"),
                          Column(
                            children: [

                              Text("Day : $day",style: TextStyle(color: Colors.black,fontSize: 30),),

                              Text("Motor Status : $status",style: TextStyle(color: Colors.black,fontSize:20),),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child:Container(
                                    height: 50,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        border: Border.all(color: Colors.black, width: 1.5),
                                        borderRadius: BorderRadius.circular(20)),
                                    child:TextButton(
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      ),
                                      onPressed: () {
                                          changeColor();
                                      },
                                      child: Text('$status',style: TextStyle(fontSize: 20),),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child:GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => History()));
                  },
                  child: Container(
                      height: 150,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      child:
                      Column(
                        children: [
                          Expanded(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/images/history.png"),
                          )),
                          Text("History",style: TextStyle(color: Colors.black,fontSize: 20),)

                        ],
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child:GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MetersPage(),));
                  },
                  child: Container(
                      height: 150,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      child:Column(
                        children: [
                          Expanded(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/images/data.png"),
                          )),
                          Text("Sensor Readings",style: TextStyle(color: Colors.black,fontSize: 20),)

                        ],
                      )),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child:GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Weather(),));

                  },
                  child: Container(
                      height: 150,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      child:
                      Column(
                        children: [
                          Expanded(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/images/weather-news.png"),
                          )),
                          Text("Weather",style: TextStyle(color: Colors.black,fontSize: 20),)

                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child:GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Automatic(),));

                  },
                  child: Container(
                      height: 150,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      child:Column(
                        children: [
                          Expanded(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/images/transfer.png"),
                          )),
                          Text("Switch",style: TextStyle(color: Colors.black,fontSize: 20),)

                        ],
                      )),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child:Container(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage(),));

                  },
                  child: const Text('Exit',style: TextStyle(fontSize: 20),),
                )),
          ),

        ],
      ),
    );
  }
}
