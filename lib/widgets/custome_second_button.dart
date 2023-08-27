import 'package:flutter/material.dart';

class CustomeSecondButton extends StatelessWidget {
  CustomeSecondButton({this.onPressed,this.widget,Key? key}) : super(key: key);
VoidCallback? onPressed;
Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(blurRadius: 80,
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 20,
            offset: Offset(10, 10),
          )
        ],
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: widget,
      ),
    );
  }
}
