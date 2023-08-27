import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> resetEmail({required String email}) async {
    emit(ForgetPasswordLoading());
    try{
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
      emit(ForgetPasswordSuccess(Message: 'please check your email.'));
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        emit(ForgetPasswordFailure(errorMessage: 'No user found for that email.'));
      }
    }catch(e){
      emit(ForgetPasswordFailure(errorMessage: 'something wrong happen.'));
    }
  }
}
