import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String id;
  final time_send;
  final String sender;
  final String message;

  Chat({this.id, this.time_send, this.sender, this.message});
/*
  static Chat fromSnapshot(QuerySnapshot snap) {
    return Chat(
      id: snap.id,
      time_send: snap.get('time_send'),
      sender: snap.get('sender'),
      message: snap.get('message'),
    );
  }*/

}