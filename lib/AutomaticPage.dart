import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_irrigation_system/SelectionPage.dart';
import 'package:smart_irrigation_system/History.dart';
import 'package:smart_irrigation_system/Sensors.dart';
import 'package:smart_irrigation_system/Weather.dart';
import 'ManualPage.dart';
import 'globalVariable.dart';


class AutomaticPage extends StatefulWidget {

   const AutomaticPage({Key? key}) : super(key: key);

  @override
  State<AutomaticPage> createState() => _AutomaticPageState();


}


var WhichCrop;
var WhichSoil;

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

class _AutomaticPageState extends State<AutomaticPage> {

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

  @override
  Widget build(BuildContext context) {


    Size size =MediaQuery.of(context).size;
     double height=size.height;
     double width =size.width;
     read();
     read2();
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
        // backgroundColor: const Color(0xfff6f6f6),
        appBar: AppBar(
          title: Text("Automatic Mode ",style: TextStyle(fontSize: width/17),),
          automaticallyImplyLeading:false,
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
                              height: 150,
                                width:150,
                                child: Image.asset("assets/images/plant2.png")),
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Day : $day",style: TextStyle(color: Colors.black,fontSize: width/30),),
                                SizedBox(
                                  height: 60,
                                ),
                                Text("Motor Status : OFF",style: TextStyle(color: Colors.black,fontSize:width/30),),
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

                      Navigator.push(context, MaterialPageRoute(builder: (context) => History(),));
                    },
                    child:Container(
                        height: height/5,
                        width: width/2.4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20)),
                        child:
                        Column(
                          children: [
                            Expanded(child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                              child: Image.asset("assets/images/time.png"),
                            )),
                            Text("History",style: TextStyle(color: Colors.black,fontSize: width/20),)

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
                            Expanded(child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Image.asset("assets/images/data.png"),
                            )),
                            Text("Readings",style: TextStyle(color: Colors.black,fontSize: width/20),)

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
                            Expanded(child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset("assets/images/weather-news.png"),
                            )),
                            Text("Weather",style: TextStyle(color: Colors.black,fontSize: width/20),)

                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child:GestureDetector(
                    onTap: (){
                      final pageRef =FirebaseDatabase.instance.ref("Page");
                      pageRef.set(2);
                      Navigator.push(context,PageTransition(child: ManualPage(), type: PageTransitionType.size,alignment: Alignment.bottomCenter)
                      );
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
                            Expanded(child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset("assets/images/transfer.png"),
                            )),
                            Text("Switch",style: TextStyle(color: Colors.black,fontSize: width/20),)

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