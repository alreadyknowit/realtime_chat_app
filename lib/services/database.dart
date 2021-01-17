import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //get user by username to use in the search page
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .getDocuments()
        .catchError((onError) => print(onError.toString()));
  }

  //upload user info, when register and user profile change
  uploadUserInfo(userMap) {
    Firestore.instance
        .collection('users')
        .add(userMap)
        .catchError((onError) => print(onError.toString()));
  }

  //create a chat room btw two users
  createChatRoom(String chatRoomId, chatRoomMap) async{
    //print('from database: $chatRoomId and ' + chatRoomMap.toString());
   await Firestore.instance.collection('chat_rooms')
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((onError) => print(onError.toString()));
  }

  //get messages from db
storeMessages(String chatRoomId, messageMap) {
 Firestore.instance.collection('chat_rooms')
     .document(chatRoomId).collection('chat')
     .add(messageMap).catchError((onError)=>print(onError.toString()));
}
}
