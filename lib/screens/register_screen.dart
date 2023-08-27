import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/widgets/custome_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../cubits/auth_cubits/register_cubit.dart';
import '../helper/show_snackBar.dart';
import '../widgets/custome_textformfield.dart';
import 'chat_screen.dart';



class Register extends StatelessWidget {
  bool isPassword = true;
  String? email,password,username,phone;
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  static String id = 'registerScreen';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
    if(state is RegisterLoading){
      isLoading = true;
    }else if(state is RegisterSuccess){
      Navigator.pushNamed(context, Chat.id);
      isLoading = false;
    }else if(state is RegisterFailure){
      showSnackBar(context, state.errorMessage);
      isLoading = false;
    }
  },
  builder: (context, state) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        // resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(20),
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
                  child: Center(child: Text('Register',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
                ),
                SizedBox(height: 10,),
                //username
                CustomeTextFormField(hintText: 'Username', labelText: 'Username', prefixIcon: Icons.person_2_outlined,
                onChanged: (data){
                  username = data;
                },
                ),
                SizedBox(height: 20,),
                // email
                CustomeTextFormField(hintText: 'Email', labelText: 'Email', prefixIcon: (Icons.email_outlined),inputType: TextInputType.emailAddress,
                onChanged: (data){
                  email = data;
                },
                ),
                SizedBox(height: 20,),
                // password
                CustomeTextFormField(hintText: 'Password', labelText: 'Password', prefixIcon: Icons.lock_outline_rounded,
                  isObscure: isPassword,suffixIcon: isPassword ? Icons.visibility : Icons.visibility_off,
                  suffixPressed: (){
                  BlocProvider.of<RegisterCubit>(context).emit(RegisterSuffixPressed());
                      isPassword = !isPassword;
                  },
                  onChanged: (data){
                  password = data;
                  },
                ),
                SizedBox(height: 20,),
                // phone
                CustomeTextFormField(hintText: 'Phone', labelText: 'Phone', prefixIcon: Icons.phone,
                inputType: TextInputType.phone,
                  onChanged: (data){
                  phone = data;
                  },
                ),
                SizedBox(height: 20,),
                // register
                CustomeButton(text: 'Register', function: ()async{
                  if(formkey.currentState!.validate()){
                    BlocProvider.of<RegisterCubit>(context).createUser(email: email!, password: password!);
                  }
                }),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text('Already have an account ? ')),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, Login.id);
                    }, child: Text('Login Now',style: TextStyle(color: kthemeColor,fontWeight: FontWeight.bold),)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }


  Future<void> createUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email!, password: password!,
    );
  }
}


