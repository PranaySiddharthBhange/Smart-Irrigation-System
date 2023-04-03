import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_irrigation_system/AutomaticPage.dart';
import 'package:smart_irrigation_system/SelectionPage.dart';
import 'History.dart';
import 'Sensors.dart';
import 'Weather.dart';
import 'globalVariable.dart';




class ManualPage extends StatefulWidget {
  const ManualPage({Key? key}) : super(key: key);

  @override
  State<ManualPage> createState() => _ManualPageState();
}
var WhichCrop;
var WhichSoil;
var status;
Future<void> readStatus() async {

  final DataRef3 = FirebaseDatabase.instance.ref("Motor Status");
  final snapshot = await DataRef3.child('').get();
  if (snapshot.exists) {
    status= snapshot.value;
    print(status);

  } else {
    print('No data available.');
  }

}
Future<void> read() async {

  final DataRef = FirebaseDatabase.instance.ref("Database");
  final snapshot = await DataRef.child('Selection/Crop').get();
  if (snapshot.exists) {
    WhichCrop= snapshot.value;
    print(WhichCrop);

  } else {
    print('No data available.');
  }

}

Future<void> read2() async {

  final DataRef = FirebaseDatabase.instance.ref("Database");
  final snapshot = await DataRef.child('Selection/Soil').get();
  if (snapshot.exists) {
    WhichSoil= snapshot.value;
    print(WhichSoil);

  } else {
    print('No data available.');
  }

}


class _ManualPageState extends State<ManualPage> {
  DateTime? _currentBackPressTime;


  late StreamSubscription subscription;
  var isDeviceConnected=false;
  bool isAlertSet =false;
  @override
  void initState(){
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

    read();
    read2();
    readStatus();
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
                                Text("Day : $day",style: TextStyle(color: Colors.black,fontSize: width/17),),
                                Text("Motor Status :$status",style: TextStyle(color:statusColor,fontSize:width/30),),
                                Padding(
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
                                        onPressed: () {

                                             var time=DateTime.now();
                                             print(time);


                                             final REf = FirebaseDatabase.instance.ref("History");
                                             REf.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                                               "time":DateTime.now().toString(),
                                               "Status" :status.toString()
                                             });




                                             if(status==0)
                                              {



                                                changeColor();

                                                final DataRef3 = FirebaseDatabase.instance.ref("Motor Status");
                                                DataRef3.set(1);
                                              }
                                            else
                                              {
                                                changeColor();
                                                final DataRef3 = FirebaseDatabase.instance.ref("Motor Status");
                                                DataRef3.set(0);
                                              }
                                        },
                                        child: Text('$status',style: TextStyle(fontSize: 20,color: Colors.white),),
                                      )),
                                ),
                                Text("Crop :$WhichCrop",style: TextStyle(color: Colors.black,fontSize: width/30),),
                                Text("Soil :$WhichSoil",style: TextStyle(color: Colors.black,fontSize: width/30))
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
