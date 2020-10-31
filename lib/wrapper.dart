import 'package:doggtime/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';
import 'package:doggtime/models/user.dart';



class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);   //access data from auth streams //return either Home or Authenticate widget
    if (user==null){
      return Authenticate();
    }else{
      return Home(); //user get bak(user knk innawa nm)
    }
  }
}
