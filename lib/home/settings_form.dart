import 'package:doggtime/shared/loading.dart';
import 'package:doggtime/models/user.dart';
import 'package:doggtime/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formkey = GlobalKey<FormState>(); //help the validate
  final List<String> age = ['<1', '1-2', '2-5', '5-10', '10>'];
  final List<String> breed= ['New breed','Beagle','Boxer','Cocker Spaniel','Dachshund','Dalmatian','Doberman','German Shephard','Labrador','Pitbull','Rottweiler'];   //

  String _currentOName;
  String _currentDName;
  String _currentBreed;
  String _currentAge;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); //access data from auth streams (wrapper.dart)

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        //we have to pass uid.because userData stream(database.dart) need uid
        builder: (context, snapshot) {

          if (snapshot.hasData) {

            UserData userData = snapshot.data;   //data currently stored

            return Form( //wrap with stream builder
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text('Update your pet details',
                    style: TextStyle(fontSize: 18.0),),
                  SizedBox(height: 13.0),
                  TextFormField(
                    initialValue: userData.oName,          //whatever you stored name before
                    decoration: InputDecoration(
                      hintText: 'Owner name',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white, width: 3.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.pinkAccent, width: 2.0)
                      ),
                    ),
                    validator: (val) =>
                    val.isEmpty
                        ? 'Please enter a Owner name'
                        : null, //if there is value inside a box
                    onChanged: (val) {
                      setState(() {
                        _currentOName = val;
                      });
                    },

                  ),

                  SizedBox(height: 7.0),
                  TextFormField(
                    initialValue: userData.dName,          //whatever you stored name before
                    decoration: InputDecoration(
                      hintText: 'Dog name',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white, width: 3.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.pinkAccent, width: 2.0)
                      ),
                    ),
                    validator: (val) =>
                    val.isEmpty
                        ? 'Please enter a Dog name'
                        : null, //if there is value inside a box
                    onChanged: (val) {
                      setState(() {
                        _currentDName = val;
                      });
                    },

                  ),



                  SizedBox(height: 2.0),
                  //dropdown

                  DropdownButtonFormField(
                    value: _currentBreed ?? userData.breed,   //else whatever you stored before
                    items: breed.map((breed) {
                      return DropdownMenuItem(
                        value: breed, //sugar means _currentSugar
                        child: Text('$breed'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _currentBreed = val;
                      });
                    },
                  ),


                  SizedBox(height: 1.0),
                  //dropdown

                  DropdownButtonFormField(
                    value: _currentAge ?? userData.age,   //else whatever you stored before
                    items: age.map((age) {
                      return DropdownMenuItem(
                        value: age, //sugar means _currentSugar
                        child: Text('$age'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _currentAge = val;
                      });
                    },
                  ),

                  SizedBox(height: 7.0,),
                  RaisedButton(
                    color: Colors.blue[400],
                    child: Text('Update', style: TextStyle(
                      color: Colors.white,
                    ),),
                    onPressed: () async {
                      if(_formkey.currentState.validate()){                          //validate
                        await DatabaseService(uid:user.uid).updateUserData(       //we have to pass uid.because updateUserData method(database.dart) need uid
                          //else previous store data
                            _currentOName?? userData.oName,
                            _currentDName?? userData.dName,
                            _currentBreed ?? userData.breed,
                            _currentAge?? userData.age,
                        );
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}
