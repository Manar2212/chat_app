import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomeTextFormField extends StatelessWidget {
  CustomeTextFormField({required this.hintText,required this.labelText,required this.prefixIcon,this.inputType,
     this.isObscure = false,this.suffixIcon,this.suffixPressed,this.onChanged,
    Key? key});
String? hintText,labelText;
IconData? prefixIcon;
IconData? suffixIcon;
bool isObscure;
VoidCallback? suffixPressed;
TextInputType? inputType;
Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: (data){
        if(data!.isEmpty){
          return 'field is required';
        }
      },
      keyboardType:inputType,
      cursorColor: kthemeColor,
      obscureText: isObscure,
      decoration: InputDecoration(
          hintText: '${hintText}',
          hintStyle: TextStyle(color: Color(0xffa8a8a8)),
          labelText: '${labelText}',
          labelStyle: TextStyle(color: kthemeColor),
          prefixIcon: Icon(prefixIcon,color: kthemeColor,
          ),
          suffixIcon:IconButton(icon: Icon(suffixIcon,color:kthemeColor ),onPressed: suffixPressed,),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: kthemeColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: kthemeColor)
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Color(0xffa8a8a8))
          )
      ),
    );
  }
}
