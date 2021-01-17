import 'package:flutter/material.dart';
import 'package:realtime_chat_app/pages/home/chat_room.dart';
import 'package:realtime_chat_app/models/user.dart';
import 'package:realtime_chat_app/services/database.dart';
import 'package:realtime_chat_app/widgets/common.dart';

class SearchResult extends StatelessWidget {
  final String username;
  final String bio;
  SearchResult({this.username, this.bio});
  DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    createChatRoomAndStartConversation() async {
      if (username != Constants.signedUserName) {
        print('here i am');
        String chatRoomId = getChatRoomId(username, Constants.signedUserName);
        List<String> users = [username, Constants.signedUserName];
        Map<String, dynamic> chatRoomMap = {
          'users': users,
          'chat_room_id': chatRoomId
        };
        print('chat room id : $chatRoomId');
        print('chat room map: ' + chatRoomMap.toString());
        dynamic result = await _db.createChatRoom(chatRoomId, chatRoomMap);
        print(" result is :" + result.toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatRoom(chatRoomId: chatRoomId,)));
      } else {
        print('you cannot send message yourself');
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: Row(
        children: [
          myContainer(),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [myText('$username', 19), myText('$bio', 14),],
          ),
          Spacer(),
          Container(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(15),),
              padding: EdgeInsets.symmetric(
                horizontal: 12, vertical: 12,),
              child: GestureDetector(
                onTap: () {
                      createChatRoomAndStartConversation();
                     },
                  child: Text('Chat', style:
                TextStyle(color: Colors.white, fontSize: 19, decoration: TextDecoration.none),),
              ))
        ],
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
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
}
