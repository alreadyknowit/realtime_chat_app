import 'package:flutter/material.dart';
import 'package:realtime_chat_app/models/user.dart';
import 'package:realtime_chat_app/services/database.dart';


class ChatRoom extends StatefulWidget {
  final String chatRoomId;
  ChatRoom({this.chatRoomId});
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  DatabaseService _db = DatabaseService();
  TextEditingController _controller = TextEditingController();
  String message;

  storeMessageToDB(){
    if(_controller.text.isNotEmpty)
    {
        Map<String,String> messageMap ={
          "message":_controller.text,
          "sender": Constants.signedUserName,
       //   "time_send": DateTime.
        };
        _db.storeMessages(widget.chatRoomId, messageMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff41295a),
      appBar: AppBar(
        backgroundColor: Color(0xff2F0743),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    child: Expanded(
                      child: TextField(
                        controller: _controller,
                        cursorColor: Colors.amberAccent,
                        style: TextStyle(color: Colors.white54, fontSize: 19),
                        decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Message...',
                            hintStyle: TextStyle(color: Colors.white54)),
                      ),
                    ),
                  ),
                  Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                      ),
                      child: FlatButton(
                          onPressed: () {
                            storeMessageToDB();
                            },
                            child: Icon(
                            Icons.send,
                            color: Colors.deepPurpleAccent,
                          )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
