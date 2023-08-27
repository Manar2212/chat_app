part of 'forget_password_cubit.dart';

@immutable
abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}
class ForgetPasswordLoading extends ForgetPasswordState{}
class ForgetPasswordSuccess extends ForgetPasswordState{
  String Message;
  ForgetPasswordSuccess({required this.Message});
}
class ForgetPasswordFailure extends ForgetPasswordState{
  String errorMessage;
  ForgetPasswordFailure({required this.errorMessage});
}