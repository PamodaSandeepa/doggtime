import 'package:doggtime/home/pam_list.dart';
import 'package:doggtime/home/settings_form.dart';
import 'package:doggtime/models/pam.dart';
import 'package:doggtime/services/auth.dart';
import 'package:doggtime/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth= AuthService();//make a object of AuthService class in auth.dart file


  @override
  Widget build(BuildContext context) {


    void _showSettingsPanel(){                                   //reason why this mehthod inside the build widget is we need access to the context
      showModalBottomSheet(context: context, builder:(context){      //builder property returns the widget tree
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 60.0),
          child: SettingsForm(),                                //setting_form.dart
        );
      });
    }



    return StreamProvider<List<pam>>.value(
      value: DatabaseService().pams,
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.blue[700],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();  //calling a Sign out method
                },
                icon: Icon(Icons.person),
                label: Text("Logout",style: TextStyle(fontSize: 17.0),)
            ),
            FlatButton.icon(
                onPressed: (){
                  _showSettingsPanel();
                },
                icon: Icon(Icons.settings),
                label: Text('Edit',style: TextStyle(fontSize: 17.0),)
            )
          ],
        ),


        drawer: Drawer(
          child: ListView(
            //padding: EdgeInsets.all(8),
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                      color: Colors.blue[800]
                  ),
                accountName: Text("Pamoda Sandeepa"),
                accountEmail: Text("Pamodasandeepa@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  // backgroundImage: AssetImage('assets/pamoda.jpg'),
                  backgroundColor: Colors.white,
                  child: Text("P",style: TextStyle(
                    fontSize: 30,
                  ),),
                ),


              ),

              Card(
                color: Colors.blueAccent,
                child: ListTile(
                    title: Text("Home"),
                    trailing: Icon(Icons.arrow_upward),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                ),
              ),



              Card(
                color: Colors.blueAccent,
                child: ListTile(
                    title: Text("About us"),
                    trailing: Icon(Icons.arrow_upward),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('/a');        //back paminiya haki.
                    }
                ),
              ),

              Divider(),
              Card(
                color: Colors.blue[100],
                child: ListTile(
                  title: Text("Close"), //no color property
                  trailing: Icon(Icons.close),
                  onTap: ()=>Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),




        body:
          //Wrap out body with a `WillPopScope` widget that handles when a user is cosing current route

           Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/dog.jpg'),
                    fit: BoxFit.cover,
                  )
              ),
              child: PamList()),
        ),
      );

  }
}
