import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class Chat extends StatelessWidget {
  List<Message> messagesList = [];
  IconData? iconState;
  Color? iconColor;
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  static String id  = 'chatscreen';
  @override
  Widget build(BuildContext context) {
   //var email = ModalRoute.of(context)!.settings.arguments ;
   final String? email = FirebaseAuth.instance.currentUser!.email;

   return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kthemeColor,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(kLogo, height: 35,),
              Text('Chat'),
            ],
          ),
        ),
                body: Column(
                children: [
                  Expanded(
                    child: BlocConsumer<ChatCubit, ChatState>(
                  listener: (context, state) {
                    if(state is ChatLoading){
                      controller.text = state.message;
                      iconState = state.iconState;
                      iconColor = state.iconColor;
                    }
                    else if(state is ChatSuccess){
                      messagesList = state.messages;
                      iconState = state.iconState;
                      iconColor = state.iconColor;
                    }else if(state is ChatFailure){
                      controller.text = state.message;
                      iconState = state.iconState;
                      iconColor = state.iconColor;
                    }
                  },
                  builder: (context, state) {

                    return ListView.builder(
                      reverse : true,
                        controller: _scrollController,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                      return messagesList[index].id == email ? ChatBubble(message: messagesList[index],iconState: iconState!,iconColor: iconColor!,) : ChatBubbleFriend(message: messagesList[index],iconState:iconState!,iconColor: iconColor!);
                    });
                    },
                  ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xffeeeeee),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: controller,
                      cursorColor: kthemeColor,
                      // onSubmitted: (data) {
                      //   messages.add({
                      //     kMessage: data,
                      //     kCreatedAt : DateTime.now()
                      //   });
                      // },
                      decoration: InputDecoration(
                        suffixIconColor: kthemeColor,
                        contentPadding: EdgeInsets.all(15),
                        hintText: 'Write your message',
                        suffixIcon: IconButton(
                          onPressed: () {
                            BlocProvider.of<ChatCubit>(context).sendMessage(message: controller.text, email: email!);
                            controller.clear();
                            _scrollController.animateTo(
                              //_scrollController.position.maxScrollExtent,
                              0,
                              curve: Curves.fastOutSlowIn,
                              duration: const Duration(milliseconds: 600),
                            );
                          },
                          icon: Icon(Icons.send),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],

              ));
            }
          }

