
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  final ref = FirebaseDatabase.instance.ref("History");
  final statReference = FirebaseDatabase.instance.ref("mode");
  var modeNow;
  @override
  Widget build(BuildContext context) {
    statReference.get().then((value) {
      setState(() {
        modeNow=value.value;
      });
    }).onError((error, stackTrace) {
      print(error.toString());
    });
    return Scaffold(
      appBar:AppBar(
        title: Text("History"),
        backgroundColor: Colors.green,

      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          // Expanded(
          //   child: StreamBuilder(
          //
          //     stream: ref.onValue,
          //     builder: (context,AsyncSnapshot<DatabaseEvent>snapshot){
          //
          //       if(!snapshot.hasData){
          //         return const Center(child: Text("Loading..."));
          //       }
          //       else{
          //         Map<dynamic,dynamic>map=snapshot.data!.snapshot.value as dynamic;
          //          List<dynamic>list=[];
          //          list.clear();
          //          list=map.values.toList();
          //
          //         return ListView.builder(
          //           physics: const BouncingScrollPhysics(),
          //
          //             shrinkWrap: true,
          //             itemCount: snapshot.data!.snapshot.children.length,
          //             itemBuilder: (context,index){
          //           return ListTile(
          //
          //             title:
          //             Container(
          //                 height: 80,
          //                 width: 350,
          //                 padding: EdgeInsets.all(13),
          //                 decoration: BoxDecoration(
          //                     border: Border.all(color: Colors.black, width: 1.5),
          //                     borderRadius: BorderRadius.circular(20)),
          //                 child: Column(
          //                   children: [
          //                     Text(list[index]['time'],style: TextStyle(fontSize: 20),),
          //
          //                         Text(
          //                             list[index]['Status'],style: TextStyle(fontSize: 20)),
          //
          //
          //                   ],
          //                 ),
          //
          //             // title: Text(list[index]['time']),
          //             // subtitle: Text(list[index]['Status']),
          //
          //           ));
          //
          //         });
          //       }
          //
          //   }
          //   ),
          // ),
          Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild: const CircularProgressIndicator(),
                  itemBuilder: (context,snapshot,animation,index){
                    return ListTile(
                      title: Text(snapshot.child('time').value.toString()),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.child('Status').value.toString()),
                          Text(snapshot.child('Currentmode').value.toString()),

                        ],
                      ),

                    );

                  }))
        ],
      ),
    );
  }
}
