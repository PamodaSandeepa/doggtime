import 'package:flutter/material.dart';
import 'package:doggtime/models/pam.dart';

class pamTile extends StatelessWidget {

  final pam pam2;
  pamTile({this.pam2});

  Color chooseColor(String age){
    switch(age){
      case '<1':
        return Colors.green[200];
        break;
      case '1-2':
        return Colors.green[900];
        break;
      case '2-5':
        return Colors.yellow[400];
        break;
      case '5-10':
        return Colors.yellow[900];
        break;
      case '10>':
        return Colors.red[700];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    // ignore: missing_return



    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0,6.0,20.0,0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: chooseColor(pam2.age),
            ),
            title: Text(pam2.oName),
            subtitle: Text('Name:- '+pam2.dName+' , '+'Breed:- '+pam2.breed),
          ),

      ),
    );
  }
}
