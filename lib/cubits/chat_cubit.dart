import 'package:bloc/bloc.dart';
import 'package:chat_app/models/timeAgo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../constants.dart';
import '../models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages = FirebaseFirestore.instance.collection(
      '$kMessagesCollection');



  void sendMessage({required String message,required String email}){
    emit(ChatLoading(message: message, iconState: Icons.access_time_sharp, iconColor: Colors.grey,));
    try{
      messages.add({
        kMessage : message,
        kCreatedAt : DateTime.now(),
        'id':email,
      });
    }on Exception catch(e){
      emit(ChatFailure(message: message, iconState: Icons.error_outline, iconColor: Colors.red));
    }
  }

  void getMessages(){
    messages.orderBy(kCreatedAt,descending: true).snapshots().listen((event) {
      List<Message> messagesList = [];
      for(var doc in event.docs){
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList,iconState: Icons.check,iconColor: Colors.blue));
    });
  }
}
