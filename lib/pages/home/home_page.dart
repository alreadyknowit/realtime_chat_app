import 'package:flutter/material.dart';
import 'package:realtime_chat_app/pages/home/SearchPage.dart';
import 'package:realtime_chat_app/models/user.dart';
import 'package:realtime_chat_app/services/shared_preference_functions.dart';
import 'package:realtime_chat_app/widgets/common.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  getUserInfoFromSharedPrefOfSignInAndUp() async{ //made it toString be careful with that if any exp occurs
    Constants.signedUserName = await SharedPreferenceFunctions.getUserNameSharedPreference();

  }

@override
  void initState() {
   getUserInfoFromSharedPrefOfSignInAndUp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat app', style: TextStyle(letterSpacing: 5),),
        elevation: 0,
        backgroundColor: Color(0xff41295a),
        actions: [
          myContainer()
        ],
      ),
      body: Container(
        color: Color(0xff2F0743),
      
    ),

    floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>SearchPage()));
      },
          hoverColor: Colors.white54,
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.search, )
    )
    );

  }
}