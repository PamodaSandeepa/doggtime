import 'package:doggtime/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:doggtime/services/auth.dart';

class Register extends StatefulWidget {

  final Function tv;
  //create constructor for the Register widget
  Register({this.tv});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth=AuthService();

  final _formkey=GlobalKey<FormState>(); //help the validate

  bool loading=false;

  //text field state
  String email='';
  String password='';
  String error='';
  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0.0, //remove drop shadow
        title: Text('Sign up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In',style: TextStyle(
              fontSize: 18.0,
            ),),
            onPressed: ()  {
              widget.tv();  //widget refers to Register widget.cant write this.tv cuz this refers <state> object
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
                  onChanged: (val){  //val means current value in form field
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
                        loading=true;
                      });
                      dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                      if(result==null){
                        setState((){
                          error='please supply a valid email';
                          loading=false;
                        });
                      }  //else is sucessfully registered.get that user back.go to (main.dart)
                    }
                  },
                  color: Colors.blue[900],
                  child: Text('Register',style: TextStyle(
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
