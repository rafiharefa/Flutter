import 'package:cloud_firestore/cloud_firestore.dart';
import 'data_class.dart';

CollectionReference contacts = FirebaseFirestore.instance.collection('contacts');

class Database{
  static Stream<QuerySnapshot> getData(){

    //data sorted by name
    return contacts.orderBy('name', descending: false).snapshots();
  }

  //create new Data
  static Future<void> CreateData({required itemContact item}) async {
    DocumentReference docRef = contacts.doc(item.itemName);

    await docRef
        .set(item.toJson())
        .whenComplete(() => print("Data Successfully Sumbitted"))
        .catchError((e) => print(e));
  }

  //update Data
  static Future<void> UpdateData({required itemContact item}) async{
    DocumentReference docRef = contacts.doc(item.itemName);

    await docRef
        .update(item.toJson())
        .whenComplete(() => print("Data Successfully Updated"))
        .catchError((e) => print(e));

  }

  //delete Data
  static Future<void> DeleteData({required String delete}) async{
    DocumentReference docRef = contacts.doc(delete);

    await docRef
        .delete();
  }

}