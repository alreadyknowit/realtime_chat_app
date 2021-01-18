import 'package:flutter/material.dart';
import 'package:realtime_chat_app/pages/home/SearchPage.dart';
import 'package:realtime_chat_app/models/user.dart';
import 'package:realtime_chat_app/pages/profile/profile_edit.dart';
import 'package:realtime_chat_app/services/database.dart';
import 'package:realtime_chat_app/services/shared_preference_functions.dart';
import 'package:realtime_chat_app/widgets/common.dart';
import 'package:realtime_chat_app/widgets/chats_in_home_page.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseService _db = DatabaseService();


   // ignore: non_constant_identifier_names
   Stream chats, last_message;
  Widget chatRoomList()  {
    return StreamBuilder(
        stream: chats,
        builder: (context, snapshot)  {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return Chats(
                      username: snapshot.data.documents[index]
                          .data["chat_room_id"] // return chat_room id
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.signedUserName, ""),
                      chatRoomId:
                          snapshot.data.documents[index].data["chat_room_id"],
                      last_message: _db
                          .getLastMessage(snapshot
                              .data.documents[index].data[snapshot.data.documents[index]
                                  .data['chat_room_id'].toString()]
                              .toString()).toString()
                    );
                  })
              : Container();
        });
  }

  getUserInfoFromSharedPrefOfSignInAndUp() async {
    Constants.signedUserName =
        await SharedPreferenceFunctions.getUserNameSharedPreference();
      _db.getChatRooms(Constants.signedUserName).then((value) {
      setState(() {
        chats = value;
      });
    });
    Constants.bio=  await SharedPreferenceFunctions.getUserBioSharedPreference();
        _db.getChatRooms(Constants.signedUserName).then((value) {
      setState(() {
        chats = value;
      });
    });
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
          title: Text(
            'Chat app',
            style: TextStyle(letterSpacing: 5),
          ),
          elevation: 0,
          backgroundColor: Color(0xff41295a),
          actions: [
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage()));
                },
                child: myContainer()),
          ],
        ),
        body: Container(
          color: Color(0xff2F0743),
          child: chatRoomList(),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            hoverColor: Colors.white54,
            backgroundColor: Colors.deepPurpleAccent,
            child: Icon(
              Icons.search,
            )));
  }
}
