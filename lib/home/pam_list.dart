import 'package:doggtime/home/pam_tile.dart';
import 'package:doggtime/models/pam.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';      //access the data from stream

class PamList extends StatefulWidget {
  @override
  _PamListState createState() => _PamListState();
}

class _PamListState extends State<PamList> {
  @override
  Widget build(BuildContext context) {

    final pamDo=Provider.of<List<pam>>(context)??[];   //access the data from list of pam stream
    pamDo.forEach((pam1) {
      print(pam1.oName);
      print(pam1.dName);
      print(pam1.breed);
      print(pam1.age);
    });


    // print(pams.documents);
    /* for(var doc in pamDo.documents){          //get the data in pams stram(collection)
      print(doc.data); */


    //output the ui
    return ListView.builder(
      itemCount: pamDo.length,
      itemBuilder: (context, index){              //index is start with 0
        return pamTile(pam2: pamDo[index]);              //pamTile is a widget & we pass the value pam[index] to the constructor(pam_tile.dart)  //pam2 define in pam_tile.dart
      },
    );
  }

}

