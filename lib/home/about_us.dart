

import 'package:doggtime/services/auth.dart';
import 'package:flutter/material.dart';



class AboutUs extends StatelessWidget {

  final AuthService _auth= AuthService(); //make a object of AuthService class in auth.dart file

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            appBar: AppBar(
              title: Text('About Us'),
                backgroundColor: Colors.blue[700],
                elevation: 0.0,
                /*actions: <Widget>[
                   FlatButton.icon(
                     onPressed: () async {
                           await _auth.signOut();  //calling a Sign out method
                        },
                     icon: Icon(Icons.person), label: Text("Logout",style: TextStyle(fontSize: 17.0),)
                      ),
                ] */

            ),
            body: Center(
              child: Text('title'),
            ),


    );

  }
}
