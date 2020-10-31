import 'package:doggtime/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:doggtime/models/user.dart';

class AuthService{
  final FirebaseAuth _auth =FirebaseAuth.instance; //FirebaseAuth is a class(type of a object).we make private property name _auth

  //Create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){   //Firebase user to regular user method
    return user != null ? User(uid: user.uid):null;
  }

  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
    //  .map((FirebaseUser user)=>_userFromFirebaseUser(user));  //firebaseUser mapping into our user
  }

  //Sign in anon
  Future signInAnon() async{
    try{
      AuthResult result=await _auth.signInAnonymously(); //AuthResult is a type of object.result is a object.
      FirebaseUser user1=result.user; //FirebaseUser is a type of object
      return _userFromFirebaseUser(user1); //firebase user to regular user
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Sign in E-mail and Password
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password); //create user with email and password (built in firebase auth method)
      FirebaseUser user2=result.user;
      return _userFromFirebaseUser(user2); //firebase user to regular user based on User model(user.dart)
    }catch(e){
      return null;
    }
  }

  //register Email and Password
  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password); //create user with email and password (built in firebase auth method)
      FirebaseUser user2=result.user;


      //create a new document for the user with the uid
      await DatabaseService(uid: user2.uid).updateUserData('New member', 'New puppy','New breed','<1');       //we create a instance.so we have to pass the uid and after we call updateUserData function

      return _userFromFirebaseUser(user2); //firebase user to regular user based on User model(user.dart)
    }catch(e){
      return null;
    }
  }

  //Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}