import 'package:flutter/material.dart';
import 'package:realtime_chat_app/widgets/common.dart';
class SenderInfo extends StatelessWidget {
  final String username;
  SenderInfo({this.username});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, ),
      child: Row(
        children: [
          myContainer(username),
          SizedBox(width: 10,),
          usernameText('$username'),
        ],
      ),
    );
  }
}
Widget usernameText(String username){
  return Text(
      '$username',
      style: TextStyle(
      color: Colors.white,
      fontSize: 15,
      decoration: TextDecoration.none,
  ),
  );
}