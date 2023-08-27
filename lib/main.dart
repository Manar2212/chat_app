import 'package:chat_app/cubits/chat_cubit.dart';
import 'package:chat_app/cubits/auth_cubits/forget_password_cubit.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/forgetPassword_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/auth_cubits/login_cubit.dart';
import 'cubits/auth_cubits/register_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => ForgetPasswordCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        routes: {
          'Welcome' : (context) => Welcome(),
          Login.id : (context) => Login(),
          Register.id : (context) => Register(),
          Chat.id : (context) => Chat(),
          ForgetPassword.id : (contex) => ForgetPassword(),
        },
       initialRoute: 'Welcome',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Mulish'
        ),
      ),
    );
  }
}
