import 'package:flutter/material.dart';
import 'package:realtime_chat_app/models/user.dart';
import 'package:realtime_chat_app/services/database.dart';

import 'package:realtime_chat_app/widgets/message_tile_for_chatroom.dart';
import 'package:realtime_chat_app/widgets/user_info_for_chat_room_appbar.dart';

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
  Stream chatStream;

  Widget chatMessage() {
    print('method called');
    return StreamBuilder(
        stream: chatStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                        message: snapshot.data.documents[index].data["message"],
                        isSenderConstant:
                            snapshot.data.documents[index].data["sender"] ==
                                Constants.signedUserName);
                  })
              : Container();
        });
  }

  storeMessageToDB() {
    if (_controller.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": _controller.text,
        "sender": Constants.signedUserName,
        "time_send": DateTime.now().millisecondsSinceEpoch,
      };
      _db.storeMessages(widget.chatRoomId, messageMap);
    }
  }

  @override
  void initState() {
    _db.getMessages(widget.chatRoomId).then((val) {
      setState(() {
        if (val != null)
          chatStream = val;
        else
          print("val is null : " + val.toString());
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff41295a),
      appBar: AppBar(
        backgroundColor: Color(0xff2F0743),
        actions: [
            SenderInfo()
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Stack(
          children: [
            chatMessage(),
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
                            setState(() =>_controller.text =" ");
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


