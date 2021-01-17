
import 'package:realtime_chat_app/services/auth.dart';
import 'package:realtime_chat_app/pages/home/home_page.dart';
import 'package:realtime_chat_app/services/shared_preference_functions.dart';
import 'package:realtime_chat_app/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:realtime_chat_app/widgets/first.dart';
import 'package:realtime_chat_app/widgets/forgot.dart';
import 'package:realtime_chat_app/widgets/loading.dart';
import 'package:realtime_chat_app/widgets/textLogin.dart';
import 'package:realtime_chat_app/widgets/verticalText.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email, password, username;
  bool isLoading = false;
  String error= " ";

  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      SharedPreferenceFunctions.saveUserEmailSharedPreference(email);
      dynamic result = await _auth.signInEmail(email, password);

      if(result != null){
        SharedPreferenceFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }

      if (result == null) {
        setState(() {
          error= "Email or password wrong";
          setState(() => isLoading = false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() : Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Color(0xff2F0743), Color(0xff41295a)]),
        ),
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    VerticalText(),
                    TextLogin(),
                  ]),
                  Text(error, style: TextStyle(fontSize: 22, color: Colors.red)),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                          validator: (val) => !isEmail(val) ? 'Invalid email!' : null,
                          onChanged:(val)=> email=val,    
                          style: TextStyle(
                          color: Colors.white,
                          ),
                          decoration: myDecoration('EMAIL')),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (value) => value.length < 8
                            ? "Password must be at least 8 characters"
                            : null,
                        onChanged: (val) => password =val,    
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: true,
                        decoration: myDecoration('PASSWORD'),
                      ),
                    ),
                  ),
                  Forgot(),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, right: 50, left: 200),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 50,
                //      width: MediaQuery.of(context).size.width,
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
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          signIn();
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
                  FirstTime(),
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
