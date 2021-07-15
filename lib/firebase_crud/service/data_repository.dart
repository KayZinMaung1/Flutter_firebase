import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DataRepository {
  FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future<void> addData({required String name,required String age}) async{
    Map<String,dynamic> requestData = {
      "name": name,
      "age": age,
      "createdAt": DateTime.now()
    };
    await _firebase
    .collection("user")
    .add(requestData)
    .whenComplete(() => print("Add successfully!"));
  }

  Stream<QuerySnapshot> readData(){
    var getUser = _firebase.collection("user").orderBy("createdAt",descending: false);
    return getUser.snapshots(); 
  }

  Future<void> updateData ({required String name,required String age,required String docId}) async{
    Map<String,dynamic> requestData = {
      "name": name,
      "age": age,
    };

    await _firebase
    .collection("user")
    .doc(docId)
    .update(requestData)
    .whenComplete(() => print("Update Successfully!!"));
  }
  
  Future<void> deleteUser({required String docId}) async{
    DocumentReference getUser =  _firebase.collection("user").doc(docId);
    await getUser.delete()
    .whenComplete(() => print("Deleted Successfully!!"));
  }

}