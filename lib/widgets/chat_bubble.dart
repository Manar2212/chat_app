import 'package:chat_app/models/timeAgo.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../constants.dart';
import '../models/message.dart';

class ChatBubble extends StatelessWidget {
   ChatBubble({
   required this.message,
   required this.iconState,
   required this.iconColor,
  super.key,
  });
   Message message;
   IconData iconState;
   Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 20,top: 20,bottom: 20,right: 20),
        margin: EdgeInsets.only(left: 15,right: 10,top: 10,bottom: 10),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0.3,
              blurRadius: 2,
              offset: Offset(1, 2),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message.message,style: TextStyle(fontSize: 17),),
            SizedBox(width: 10,),
            Text('${TimeAgo.timeAgoSinceDate(message.createdAt)}',style: TextStyle(fontSize: 13,color: Colors.grey[600]),),
            Icon(iconState,color: iconColor),
          ],
        ),
      ),
    );
  }
}



class ChatBubbleFriend extends StatelessWidget {
  ChatBubbleFriend({
  required this.message,
  required this.iconState,
  required this.iconColor,
  super.key,
});
Message message;
IconData iconState;
Color iconColor;

@override
Widget build(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      padding: EdgeInsets.only(left: 20,top: 20,bottom: 20,right: 20),
      margin: EdgeInsets.only(left: 15,right: 10,top: 10,bottom: 10),
      decoration: BoxDecoration(
        color: Color(0xffc3e4fb),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0.3,
            blurRadius: 2,
            offset: Offset(1, 2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message.message,style: TextStyle(fontSize: 17),),
          SizedBox(width: 10,),
          Text('${TimeAgo.timeAgoSinceDate(message.createdAt)}',style: TextStyle(fontSize: 13,color: Colors.grey[600]),),
          SizedBox(width: 2,),
          Icon(iconState,color: iconColor),
        ],
      ),
    ),
  );
}
}