import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit.dart';
import 'package:chat_app/helper/show_snackBar.dart';
import 'package:chat_app/screens/forgetPassword_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custome_button.dart';
import 'package:chat_app/widgets/custome_second_button.dart';
import 'package:chat_app/widgets/custome_textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../cubits/auth_cubits/login_cubit.dart';
import 'chat_screen.dart';



class Login extends StatelessWidget{
  static String id = 'loginScreen';
  bool isPassword = true;
  bool isLoading = false;
  String? email,password;
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    if(state is LoginLoading){
      isLoading = true;
    }else if(state is LoginSuccess){
      BlocProvider.of<ChatCubit>(context).getMessages();
      Navigator.pushNamed(context, Chat.id);
      isLoading = false;
    }else if(state is LoginFailure){
      showSnackBar(context, state.errorMessage);
      isLoading = false;
    }
  },
  builder:(context,state) => ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key:  formkey,
            child: ListView(
              children: [
                Image.asset('assets/telegram.png',
                  width: 100,
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: Text('Login',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                ),
                SizedBox(height: 30,),
                //email
                CustomeTextFormField(hintText: 'Email', labelText: 'Email', prefixIcon: (Icons.email_outlined),inputType: TextInputType.emailAddress,
                onChanged: (data){
                  email = data;
                },
                ),
                SizedBox(height: 30,),
                //password
                CustomeTextFormField(hintText: 'Password', labelText: 'Password', prefixIcon: Icons.lock_outline_rounded,
                isObscure: isPassword,suffixIcon: isPassword ? Icons.visibility : Icons.visibility_off,
                  suffixPressed: (){
                  BlocProvider.of<LoginCubit>(context).emit(LoginSuffixPressed());
                    isPassword = !isPassword;
                  },
                  onChanged: (data){
                  password = data;
                  },
                ),
                // forget password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, ForgetPassword.id);
                    }, child: Text('Forget Password ?',style: TextStyle(color: kthemeColor),))
                  ],
                ),
                //login
                CustomeButton(text: 'Login', function: ()async{
                  if(formkey.currentState!.validate()){
                    BlocProvider.of<LoginCubit>(context).signIn(email: email!, password: password!);
                  }
                }),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text('Don\'t have an account ? ')),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, Register.id);
                    }, child: Text('Register Now',style: TextStyle(color: kthemeColor,fontWeight: FontWeight.bold),)),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Divider(
                          thickness: 1,
                          endIndent: 10,
                        )
                    ),
                    Text('OR',style: TextStyle(fontWeight: FontWeight.bold),),

                    Expanded(
                        child: Divider(
                          thickness: 1,
                          indent: 10,
                        )
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                //Sign in with google
                CustomeSecondButton(
                  onPressed: ()async{
                    BlocProvider.of<LoginCubit>(context).signInwithgoogle();
                  },
                  widget: Image.asset('assets/google.png',width:30,height: 30,),
                )
              ],
            ),
          ),
        ),
      ),
    ),
);
  }

  Future<void> signIn() async {
     var auth = FirebaseAuth.instance;
    UserCredential user  =  await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }

  Future<void> signInwithgoogle() async {
    GoogleSignInAccount?  googleuser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth =  await googleuser?.authentication;
    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithCredential(credential);
  }
}


