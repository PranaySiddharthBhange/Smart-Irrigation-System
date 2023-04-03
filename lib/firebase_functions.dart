import 'package:firebase_database/firebase_database.dart';


var currentPageNumber;

  Future<void> getCurrentPage() async {

  final currentPage =FirebaseDatabase.instance.ref("currentPage");
  final snapshot = await currentPage.get();
  if (snapshot.exists) {
    currentPageNumber= snapshot.value;
    print(currentPageNumber);
  }else{
    print("No Data Available");
  }
}
