import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());


  Future<void> signIn({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      var auth = FirebaseAuth.instance;
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        emit(LoginFailure(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        emit(LoginFailure(
            errorMessage: 'Wrong password provided for that user.'));
      }
    }catch (e){
      emit(LoginFailure(errorMessage: 'something error happen'));
    }
  }

    Future<void> signInwithgoogle() async {
      emit(LoginLoading());
      try {
        GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
        GoogleSignInAuthentication? googleAuth = await googleuser
            ?.authentication;
        OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        var auth = FirebaseAuth.instance;
        UserCredential user = await auth.signInWithCredential(credential);
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(errorMessage: 'something wrong happen.'));
      }
    }
  }
