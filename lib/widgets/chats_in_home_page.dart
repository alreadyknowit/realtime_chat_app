import 'package:flutter/material.dart';
import 'package:realtime_chat_app/pages/home/chat_room.dart';
import 'package:realtime_chat_app/widgets/common.dart';


class Chats extends StatelessWidget {
  final String username;
  final String chatRoomId;
  final String last_message;
  final String user_image;
  Chats({this.username, this.chatRoomId, this.last_message, this.user_image});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatRoom(chatRoomId: chatRoomId,)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, ),
        child: Row(
          children: [
            myContainer(),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [myText('$username', 19), myText('$last_message', 14),],
            ),
          ],
        ),
      )
    );
  }
}
Widget myText(String textInput, int fontSize) {
  return Text(
    '$textInput',
    style: TextStyle(
      color: Colors.white,
      fontSize: 15,
      decoration: TextDecoration.none,
    ),
  );
}
