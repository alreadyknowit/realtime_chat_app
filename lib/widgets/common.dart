import 'package:flutter/material.dart';


InputDecoration myDecoration(String text) {
  return InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurpleAccent),
    ),
    border: InputBorder.none,
    labelText: '$text',
    labelStyle: TextStyle(
      color: Colors.white70,
    ),
  );
}

Container myContainer(String username){
  return Container(
      alignment: Alignment.centerRight,
      width: 66,
      height: 50,
      child:  CircleAvatar(
        backgroundColor: Color(0xff5384d4),
        child: Text('$username'.substring(0,1).toUpperCase(),
          style: TextStyle(fontSize: 33),
        ),
      ),
      decoration:  BoxDecoration(
          shape: BoxShape.circle,
       /*   image: DecorationImage(
              fit: BoxFit.cover,
              image:  AssetImage('assets/profile/profile.jpg')
          )*/
      )
  );
}
