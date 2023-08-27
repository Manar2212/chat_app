import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custome_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/telegram.png',
            width: 100,
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Get Started',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 80,),
            CustomeButton(text: 'Login',
            function: (){
              Navigator.pushNamed(context, Login.id);
            },
            ),
            SizedBox(height: 30,),
            CustomeButton(text: 'Register',
            function: (){
              Navigator.pushNamed(context, Register.id);
            },
            ),
          ],
        ),
      ),
    );
  }
}
