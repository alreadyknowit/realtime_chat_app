import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realtime_chat_app/pages/home/chat_room.dart';
import 'package:realtime_chat_app/models/user.dart';
import 'package:realtime_chat_app/services/database.dart';
import 'package:realtime_chat_app/widgets/loading.dart';
import 'package:realtime_chat_app/widgets/search_result.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DatabaseService _db = DatabaseService();
  TextEditingController _controller = TextEditingController();
  String text = "SEARCH FOR USER";
  bool isLoading = false;
  QuerySnapshot _snapshot;
  getUserFromFirestore() {
    _db.getUserByUsername(_controller.text).then((val) {
      if (val != null) setState(() => _snapshot = val);
      if (val == null)
        setState(() {
          print('result null');
        });
    });
  }
/*
  createChatRoomAndStartConversation(String username){
    if(username != Constants.signedUserName){
      String chatRoomId = getChatRoomId(username, Constants.signedUserName);
      List<String> users = [username, Constants.signedUserName];
      Map<String, dynamic> chatRoomMap = {
        'users': users,
        'chat_room_id':chatRoomId
      };
      print("Chat room map is"+ chatRoomMap.toString());
      _db.createChatRoom(chatRoomId,chatRoomMap);
      Navigator.push(context, MaterialPageRoute(builder: (context) =>ChatRoom(chatRoomId: chatRoomId,)));
    }else{ print('you cannot send message yourself'); }
  }*/
 // createChatRoom: createChatRoomAndStartConversation(_snapshot.documents[index].data['username']),
  buildUserList() {
    return _snapshot != null
        ? SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: _snapshot.documents.length,
              itemBuilder: (context, index) {
                return SearchResult(
                  username: _snapshot.documents[index].data['username'],
                  bio: _snapshot.documents[index].data['bio'],
                );
              }),
        )
        : Loading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2F0743),
      body: SafeArea(
          child: Container(
              child: Column(
        children: [
          Container(
            color: Color(0xff41295a),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white54, fontSize: 19),
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: '$text',
                        hintStyle: TextStyle(color: Colors.white54)),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    getUserFromFirestore();
                  },
                  child: Icon(
                    Icons.search_outlined,
                    size: 50,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ],
            ),
          ),
          isLoading ? Loading() : buildUserList(),
        ],
      ))),
    );
  }
}
//TODO: This method create two separate chatRooms if the usernames first letter is same
//Function to create a unique chat_room id
getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
