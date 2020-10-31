import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doggtime/models/pam.dart';
import 'package:doggtime/models/user.dart';


class DatabaseService {

  final String uid;

  DatabaseService(
      {this.uid}); //Constructor.when we create a instance in the future.we have to pass the uid

  //collection reference
  final CollectionReference dogsCollection = Firestore.instance.collection(
      'doggs'); //FireStore is a class database.collection data is pamo.reference is pamCollection

  Future updateUserData(String oName, String dName, String breed, String age) async {
    return await dogsCollection.document((uid)).setData({
      //auth.dart eken ena uid eeka gannawa(new user) and set data coming from auth.dart
      'ownerName': oName,
      'dogName': dName,
      'breed': breed,
      'age': age,
    });
  }

  //pam list from snapshot(pam.dart)
  List<pam> _pamListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){     //we get documents(pam_list.dart).we refer each document as a doc.(from map method)
      return pam(              //pam.dart file single pam object
          oName: doc.data['ownerName']??'', // name is property is a key
          dName: doc.data['dogName']??'',
          breed: doc.data['breed']??'breed',
          age: doc.data['age']??'<1'
      );
    }).toList();             //without toList( ), it return iterable
  }


  //get pams stream
  Stream<List<pam>> get pams {
    return dogsCollection.snapshots()               //pamCollection eke athi snapshots snapshots() method eken labaganima sidu wei.
        .map(_pamListFromSnapshot);          //we have to call _pamListFromSnapshot everytime we get snapshot.we need pam object
  }

  //userData from snapshot(user.dart)
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      oName: snapshot.data['ownerName'],
      dName: snapshot.data['dogName'],
      breed: snapshot.data['breed'],
      age: snapshot.data['age'],

    );
  }


  //get user doc stream
  Stream<UserData> get userData{
    return dogsCollection.document(uid).snapshots()   //pamCollection eke athi adala uid ekata adala snapshots eweema sidu wei.
        .map(_userDataFromSnapshot);                 //we don't work with document snapshot.so api map krnwa userData object ekak retuen krna widihata
  }


}