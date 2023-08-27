import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/auth_cubits/forget_password_cubit.dart';
import 'package:chat_app/widgets/custome_button.dart';
import 'package:chat_app/widgets/custome_textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snackBar.dart';



class ForgetPassword extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey();
  String? email;
  bool isLoading = false;
  static String id = 'forgetMessage';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
  listener: (context, state) {
    if(state is ForgetPasswordLoading){
      isLoading = true;
    }else if(state is ForgetPasswordSuccess){
      Navigator.pop(context);
      isLoading = false;
      showSnackBar(context, state.Message);
    }else if(state is ForgetPasswordFailure){
      showSnackBar(context, state.errorMessage);
      isLoading = false;
    }
  },
  builder: (context,state) => ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.grey,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                Image.asset('assets/telegram.png',
                  width: 100,
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: Text('Forget Password',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                ),
                SizedBox(height: 30,),
                CustomeTextFormField(hintText: 'Email', labelText: 'Email', prefixIcon: Icons.email,
                inputType: TextInputType.emailAddress,
                  onChanged: (data){
                  email = data;
                  },
                ),
                SizedBox(height: 30,),
                CustomeButton(text: 'Send', function: ()async{
                  if(formkey.currentState!.validate()){
                    BlocProvider.of<ForgetPasswordCubit>(context).resetEmail(email:email!);
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    ),
);
  }

  Future<void> resetEmail() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email!);
  }
}
