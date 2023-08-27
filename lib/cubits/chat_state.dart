part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class ChatLoading extends ChatState {
  String message;
  IconData iconState;
  Color iconColor;
  ChatLoading({required this.message,required this.iconState,required this.iconColor});
}
class ChatSuccess extends ChatState {
  List<Message> messages;
  IconData iconState;
  Color iconColor;
  ChatSuccess({required this.messages,required this.iconState,required this.iconColor});
}
class ChatFailure extends ChatState {
  String message;
  IconData iconState;
  Color iconColor;
  ChatFailure({required this.message,required this.iconState,required this.iconColor});
}
