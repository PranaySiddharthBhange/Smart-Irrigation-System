import 'package:flutter/material.dart';
import 'ManualPage.dart';
import 'globalVariable.dart';

class Automatic extends StatefulWidget {
  const Automatic({Key? key}) : super(key: key);

  @override
  State<Automatic> createState() => _AutomaticState();
}

class _AutomaticState extends State<Automatic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(

          ),
          SizedBox(
            height: 10,
          ),

          Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
              child:TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Exit',style: TextStyle(fontSize: 20),),
              )),
          Container(
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
              child:TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                },
                child: const Text('Manual',style: TextStyle(fontSize: 20),),
              )),
          Container(
              height: 60,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
              child:TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                },
                child: const Text('Motor Status',style: TextStyle(fontSize: 20),),
              )),
          Container(
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
              child:TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                },
                child: const Text('Schedule',style: TextStyle(fontSize: 20),),
              )),
          Container(
              height: 60,
              width: 180,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
              child:TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                },
                child: const Text('Sensor Readings',style: TextStyle(fontSize: 20),),
              )),
          Container(
              height: 60,
              width: 140,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
              child:TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                },
                child: const Text('Water Usage',style: TextStyle(fontSize: 20),),
              )),
          Container(
              height:80,
              width: 210,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
              child:TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                },
                child: const Text('Weather Information',style: TextStyle(fontSize: 20),),
              )),
          Container(
              height: 60,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
              child:TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                },
                child: const Text('History',style: TextStyle(fontSize: 20),),
              )),
        ],
      ),
    );
  }
}
