import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
   CustomeButton({@required this.text,@required this.function,Key? key}) : super(key: key);
   String? text;
   VoidCallback? function;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: kthemeColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(blurRadius: 80,
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 20,
            offset: Offset(10, 10),
          )
        ],
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text('$text',style: TextStyle(fontSize: 20,color: Colors.white),),
      ),
    );
  }
}
