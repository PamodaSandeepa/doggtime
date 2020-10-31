import 'package:doggtime/home/about_us.dart';
import 'package:doggtime/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'models/user.dart';
import 'wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.yellowAccent,
        ),
        title: 'splash screen',
        home: SplashScreen(),
        routes: {
          '/wrap':(context)=> Wrapper(),
          '/a':(context)=>AboutUs(),
        },
      ),
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => Navigator.of(context).pushReplacementNamed('/wrap'));   //can't come back
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent[100],
                ),
              ),
              ListView(
                children: <Widget>[
                  Padding(
                    padding:EdgeInsets.only(top:50.0),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 150.0,
                          backgroundImage: AssetImage('assets/logo_transparent.png'),
                        ),
                        SizedBox(height: 150.0,),
                        CircularProgressIndicator(
                          strokeWidth: 4.0,
                          backgroundColor: Colors.black,
                        ),
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text("Designed by \n Pamoda Sandeepa",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),)
                ],
              )
            ]
        )
    );
  }
}