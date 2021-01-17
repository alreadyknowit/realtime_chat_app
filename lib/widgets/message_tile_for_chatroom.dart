import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSenderConstant;
  MessageTile({this.message, this.isSenderConstant});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      alignment:
      isSenderConstant ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          child: Column(
            children: [
              Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
          decoration: BoxDecoration(

              gradient: LinearGradient(
                  colors: isSenderConstant
                      ? [Colors.deepPurple, Colors.deepPurple]
                      : [Colors.teal, Colors.teal]),
              borderRadius:BorderRadius.all( Radius.circular(10))
          ) ),
    );
  }
}