import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  String text = "SEARCH FOR";

  QuerySnapshot snapshot;
  getUserFromFirestore() {
    _db.getUserByUsername(_controller.text).then((val) {
      if (val != null) setState(() => snapshot = val);
      if (val == null)
        setState(() {
          print('result null');
        });
    });
  }
  buildUserList() {
    return snapshot !=null
        ? SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.documents.length,
              itemBuilder: (context, index) {
                return SearchResult(
                  username: snapshot.documents[index].data['username'],
                  bio: snapshot.documents[index].data['bio'],
                );
              }),
        )
        : Container();
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
          buildUserList(),
        ],
      ))),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
