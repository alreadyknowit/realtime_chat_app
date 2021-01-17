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

Container myContainer(){
  return Container(
      alignment: Alignment.centerRight,
      width: 66,
      height: 50,
      decoration:  BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image:  AssetImage('assets/profile/profile.jpg')
          )
      )
  );
}
