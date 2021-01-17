import 'package:realtime_chat_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Return a user model
  User _myUser(FirebaseUser firebaseUser){
    return firebaseUser != null ? User(userID: firebaseUser.uid) : null ;
  }


  //Sign in using email and password
  Future signInEmail(String email, String pass) async{
    try{
      AuthResult result =await _auth.signInWithEmailAndPassword(email: email, password:pass);
      FirebaseUser _user= result.user;
    return _myUser(_user);
    }catch(e){
      print(e.toString());
    }
  }


  //Sign up with email and password
Future registerEmail(String email, String pass) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      FirebaseUser _user = result.user;
      return _myUser(_user);
    }catch(e){
      print(e.toString());
    }
}

//Reset password
Future resetPass(String mail) async{
    try{
      return await _auth.sendPasswordResetEmail(email: mail);
    } catch(e){
      print(e.toString());
      print("Couldn't reset");
    }
}


//Sign out
Future signOut() async{
    try{
      return  await _auth.signOut();
    }catch(e){
      print(e.toString());
      print("Couldn't sign out");
    }
}

}