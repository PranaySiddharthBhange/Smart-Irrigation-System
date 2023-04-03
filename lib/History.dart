import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  final ref = FirebaseDatabase.instance.ref("History");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("History"),
        backgroundColor: Colors.green,

      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
              stream: ref.onValue,
              builder: (context,AsyncSnapshot<DatabaseEvent>snapshot){
                if(!snapshot.hasData){
                  return Center(child: Text("Loading..."));
                }
                else{
                   Map<dynamic,dynamic>map=snapshot.data!.snapshot.value as dynamic;
                   List<dynamic>list=[];
                   list.clear();
                   list=map.values.toList();

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.snapshot.children.length,
                      itemBuilder: (context,index){
                    return ListTile(
                      title:
                      Container(
                          height: 80,
                          width: 350,
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Text(list[index]['time'],style: TextStyle(fontSize: 20),),

                                  Text(
                                      list[index]['Status'],style: TextStyle(fontSize: 20)),


                            ],
                          ),

                      // title: Text(list[index]['time']),
                      // subtitle: Text(list[index]['Status']),

                    ));

                  });
                }

            }
            ),
          ),
        ],
      ),
    );
  }
}
