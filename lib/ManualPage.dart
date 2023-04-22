import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_irrigation_system/AutomaticPage.dart';
import 'package:smart_irrigation_system/SelectionPage.dart';
import 'package:smart_irrigation_system/firebase_functions.dart';
import 'History.dart';
import 'Sensors.dart';
import 'Weather.dart';
import 'globalVariable.dart';




class ManualPage extends StatefulWidget {

  ManualPage({Key? key}) : super(key: key);

  @override
  State<ManualPage> createState() => _ManualPageState();
}
var WhichCrop;
var WhichSoil;
//variable store value of motor status from database
var status;
//variable store value of mode


//
// var mode;





class _ManualPageState extends State<ManualPage> {
  DateTime? _currentBackPressTime;


  late StreamSubscription subscription;
  var isDeviceConnected=false;
  bool isAlertSet =false;




  @override
  void initState(){
    print("in manual page");
    getConnectivity();
    super.initState();
  }

  getConnectivity()=>
      subscription=Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{
        isDeviceConnected =await InternetConnectionChecker().hasConnection;
        if(!isDeviceConnected && isAlertSet==false){
          showDialogBox();
          setState(() {
            isAlertSet=true;
          });
        }
      });
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }



  Color statusColor = Colors.green;
  void changeColor() {
    if (statusColor == Colors.green) {
      setState(() {
        statusColor = Colors.deepOrange;

      });

    } else {
      setState(() {
        statusColor = Colors.green;

      });
    }
  }


  @override
  Widget build(BuildContext context) {

    Size size =MediaQuery.of(context).size;
    double height=size.height;
    double width =size.width;

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
          title: Text("Manual Mode",style: TextStyle(fontSize: width/17)),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          actions: [
            IconButton(onPressed: (){
              final pageRef =FirebaseDatabase.instance.ref("Page");
              pageRef.set(0);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SelectionPage(),));

            }, icon: Icon(Icons.logout_outlined,size: width/14),)
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: height/40,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                      height: height/3.2,
                      width: width/1.1,
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
                            Container(
                              height: height/3.2,
                                width: width/2.5,
                                child: Image.asset("assets/images/plant2.png")),
                            Column(
                              children: [
                                Expanded(
                                    child: StreamBuilder(
                                        stream: FirebaseDatabase.instance.ref('Date').onValue,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                                            var databaseSnapshot = databaseEvent.snapshot; // 👈 Get the DataSnapshot from the DatabaseEvent
                                            print('Snapshot: ${databaseSnapshot.value}');

                                            DateTime dateTimeCreatedAt = DateTime.parse('${databaseSnapshot.value}');
                                            DateTime dateTimeNow = DateTime.now();
                                            differenceInDays = dateTimeNow.difference(dateTimeCreatedAt).inDays;

                                            return Text("Day : $differenceInDays",style: TextStyle(color: Colors.black),);
                                          } else {
                                            return CircularProgressIndicator();
                                          }      }
                                    )
                                ),
                                Expanded(
                                    child: StreamBuilder(
                                        stream: FirebaseDatabase.instance.ref('status').onValue,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                                            var databaseSnapshot = databaseEvent.snapshot; // 👈 Get the DataSnapshot from the DatabaseEvent
                                            print('Snapshot: ${databaseSnapshot.value}');
                                            return Text("Motor Status : ${databaseSnapshot.value.toString()}",style: TextStyle(color: Colors.black),);
                                          } else {
                                            return CircularProgressIndicator();
                                          }      }
                                    )
                                ),
                                Expanded(
                                    child: StreamBuilder(
                                        stream: FirebaseDatabase.instance.ref('soil').onValue,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                                            var databaseSnapshot = databaseEvent.snapshot; // 👈 Get the DataSnapshot from the DatabaseEvent
                                            print('Snapshot: ${databaseSnapshot.value}');
                                            return Text("Selected Soil : ${databaseSnapshot.value.toString()}",style: TextStyle(color: Colors.black),);
                                          } else {
                                            return CircularProgressIndicator();
                                          }      }
                                    )
                                ),
                                Expanded(
                                    child: StreamBuilder(
                                        stream: FirebaseDatabase.instance.ref('crop').onValue,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                                            var databaseSnapshot = databaseEvent.snapshot; // 👈 Get the DataSnapshot from the DatabaseEvent
                                            print('Snapshot: ${databaseSnapshot.value}');
                                            return Text("Selected Crop : ${databaseSnapshot.value.toString()}",style: TextStyle(color: Colors.black),);
                                          } else {
                                            return const CircularProgressIndicator();
                                          }      }
                                    )
                                ),

                                StreamBuilder(
                                    stream: FirebaseDatabase.instance.ref('status').onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        var databaseEvent = snapshot.data!; // 👈 Get the DatabaseEvent from the AsyncSnapshot
                                        var databaseSnapshot = databaseEvent.snapshot; // 👈 Get the DataSnapshot from the DatabaseEvent
                                        print('Snapshot: ${databaseSnapshot.value}');
                                        return Padding(
                                          padding: const EdgeInsets.all(16),
                                          child:Container(
                                              height: 50,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                  color: statusColor,
                                                  border: Border.all(color: Colors.black, width: 1.5),
                                                  borderRadius: BorderRadius.circular(20)),
                                              child:TextButton(
                                                style: ButtonStyle(
                                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                ),
                                                onPressed: () async {
                                                  var overStatus;
                                                  final statRef=FirebaseDatabase.instance.ref('status');
                                                 await statRef.get().then((value) {
                                                    setState(() {
                                                      overStatus=value.value;
                                                    });
                                                  });
                                                  print(overStatus);
                                                  if(overStatus=='Off'){
                                                    statRef.set('On');
                                                  }
                                                  else{
                                                    statRef.set('Off');
                                                  }

                                                  var time=DateTime.now();
                                                  print(time);

                                                  final historyRef = FirebaseDatabase.instance.ref("History");
                                                  historyRef.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                                                    "time":DateTime.now().toString(),
                                                    "Status" :databaseSnapshot.value.toString(),
                                                    "Currentmode" : 'Manual'
                                                  });

                                                },
                                                child: Text('${databaseSnapshot.value}',style: TextStyle(fontSize: 20,color: Colors.white),),
                                              )),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }      }
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
              height: height/130,
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
                        height: height/5,
                        width: width/2.4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20)),
                        child:
                        Column(
                          children:[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),

                                child: Image.asset("assets/images/time.png"),
                              ),
                            ),
                            Text("History",style: TextStyle(color: Colors.black,fontSize:width/20),)

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
                        height: height/5,
                        width: width/2.4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20)),
                        child:Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Image.asset("assets/images/data.png"),
                              ),
                            ),
                            Text("Readings",style: TextStyle(color: Colors.black,fontSize: 20),)

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
                        height: height/5,
                        width: width/2.4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20)),
                        child:
                        Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset("assets/images/weather-news.png"),
                              ),
                            ),
                            Text("Weather",style: TextStyle(color: Colors.black,fontSize: 20),)

                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child:GestureDetector(
                    onTap: (){

                      final pageRef =FirebaseDatabase.instance.ref("Page");
                      pageRef.set(1);

                      Navigator.push(context,PageTransition(child: AutomaticPage(), type: PageTransitionType.size,alignment:Alignment.bottomCenter));

                    },
                    child: Container(
                        height: height/5,
                        width: width/2.4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20)),
                        child:Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset("assets/images/transfer.png"),
                              ),
                            ),
                            Text("Switch",style: TextStyle(color: Colors.black,fontSize: 20),)

                          ],
                        )),
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
  showDialogBox()=> showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) =>CupertinoAlertDialog(
        title: Text("No Connection"),
        content: Text("Please check your internet connection"),
        actions:<Widget> [
          TextButton(onPressed: ()async{
            Navigator.pop(context,'Cancel');
            setState(()=>isAlertSet =false);
            isDeviceConnected=
            await InternetConnectionChecker().hasConnection;
            if(!isDeviceConnected){
              showDialogBox();
              setState(()=>isAlertSet=true);
            }

          }, child: Text("OK"))
        ],
      )
  );
}
