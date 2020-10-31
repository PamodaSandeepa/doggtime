import 'package:doggtime/services/auth.dart';
import 'package:doggtime/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function tv;
  //create constructor for the SignIn widget
  SignIn({this.tv});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth=AuthService(); //class(Auth Service widget) eke object ekak create kala

  final _formkey=GlobalKey<FormState>(); //help the validate

  bool loading=false;                    //for loading screen

  //text field state
  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(   //if loading is true then return the loading screen else back to current page
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0.0, //remove drop shadow
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register',style: TextStyle(
              fontSize: 18.0,)),
            onPressed: () {
              widget.tv();  //widget refers to SignIn widget.cant write this.tv cuz this refers <state> object
              //when we call tv it's call to toggleView() function
            },
          )
        ],

      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 70.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,width: 3.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pinkAccent,width: 2.0)
                    ),
                  ),

                  validator: (val)=>val.isEmpty?'Enter an email':null,  //Empty or not
                  onChanged: (val){  //val means curren value in form field
                    setState(()=>email=val);
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,width: 3.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pinkAccent,width: 2.0)
                    ),
                  ),

                  validator: (val)=>val.length<6?'Enter an password 6+ chars long':null,
                  obscureText: true, //don't see text
                  onChanged: (val){
                    setState(()=>password=val);
                  },
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  onPressed: () async {
                    if(_formkey.currentState.validate()){//valid or not
                      setState(() {
                        loading=true;           //valid nam loading wenawa
                      });

                      dynamic result=await _auth.signInWithEmailAndPassword(email, password);
                      if(result==null){
                        setState(() {
                          error='could not sign in with those credentials';
                          loading=false;
                        });
                      }  //else is sucessfully registered.get that user back.go to (main.dart)
                    }
                  },
                  color: Colors.blue[900],
                  child: Text('Sign in',style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),),
                ),
                SizedBox(height: 12.0,),
                Text(error,style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0
                ),)
              ],
            ),
          )
      ),
    );
  }
}
