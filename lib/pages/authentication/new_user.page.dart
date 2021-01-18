import 'package:realtime_chat_app/models/user.dart';
import 'package:realtime_chat_app/services/auth.dart';
import 'package:realtime_chat_app/pages/home/home_page.dart';
import 'package:realtime_chat_app/services/database.dart';
import 'package:realtime_chat_app/services/shared_preference_functions.dart';
import 'package:realtime_chat_app/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:realtime_chat_app/widgets/loading.dart';
import 'package:realtime_chat_app/widgets/sing_up.dart';
import 'package:realtime_chat_app/widgets/textNew.dart';
import 'package:realtime_chat_app/widgets/userOld.dart';


class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {

  DatabaseService _db = DatabaseService();
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email, password, username;
  bool isLoading = false;
  String error = " ";
  String bio = "Hey there, I am using ChatApp";

  signUpFunc() async{
    if (_formKey.currentState.validate()) {
      isLoading = true;
      Map<String, String> userMap = {
        "username": username,
        "bio": bio,
      };
      SharedPreferenceFunctions.saveUserEmailSharedPreference(email);
      SharedPreferenceFunctions.saveUserNameSharedPreference(username);
      SharedPreferenceFunctions.saveSharedPreferenceUserBio(bio);
      dynamic result = await _auth.registerEmail(
          email, password);
      if (result != null) {
        SharedPreferenceFunctions.saveUserLoggedInSharedPreference(true);
        _db.uploadUserInfo(userMap);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home()));
      }
      if (result == null)
        setState(() {
          error = "Email already in use";
          isLoading = false;
        });
      print(Constants.signedUserName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xff2F0743), Color(0xff41295a)]),
              ),
              child: ListView(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SingUp(),
                            TextNew(),
                          ],
                        ),
                        Text(error,
                            style: TextStyle(fontSize: 22, color: Colors.red)),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50, left: 50, right: 50),
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                                validator: (val) => val.length < 4
                                    ? "Please supply a valid username"
                                    : null,
                                onChanged: (val) => username = val,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: myDecoration("USERNAME")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 50, right: 50),
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                                validator: (val) =>
                                    isEmail(val) ? null : "Invalid email!",
                                //  isEmail(val) ,
                                onChanged: (val) => email = val,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: myDecoration("EMAIL")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 50, right: 50),
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                                validator: (val) => val.length < 8
                                    ? "Password must be at least 8 characters"
                                    : null,
                                onChanged: (val) => password = val,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                obscureText: true,
                                decoration: myDecoration("PASSWORD")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 40, right: 50, left: 200),
                          child: Container(
                            alignment: Alignment.bottomRight,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue[300],
                                    blurRadius:
                                        10.0, // has the effect of softening the shadow
                                    spreadRadius:
                                        1.0, // has the effect of extending the shadow
                                    offset: Offset(
                                      5.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: FlatButton(
                              onPressed: ()  {
                                  signUpFunc();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        UserOld(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
