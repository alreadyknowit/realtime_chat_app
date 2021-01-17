import 'package:flutter/material.dart';
import 'package:realtime_chat_app/pages/authentication/login.dart';
import 'package:realtime_chat_app/pages/home/home_page.dart';
import 'package:realtime_chat_app/services/shared_preference_functions.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   bool isLoggedIn = false;
  @override
  initState(){
    getLoggedInState();
    super.initState();
  }
    getLoggedInState() async {
    await SharedPreferenceFunctions.getUserLoggedInSharedPreference()
        .then((value) => {
          if(value!=null)
          setState(() => isLoggedIn = value)});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ?Home() : LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
