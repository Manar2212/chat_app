import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String message;
  final Timestamp createdAt;
  final String id;
  Message({required this.message,required this.createdAt,required this.id});

  factory Message.fromJson(jsonData){
    return Message(message : jsonData[kMessage],
    createdAt : jsonData[kCreatedAt],
      id : jsonData['id'],
    );
  }
}