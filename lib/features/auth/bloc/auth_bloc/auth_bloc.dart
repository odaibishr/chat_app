import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthEventLogin) {
        emit(LoginLoading());
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'user-not-found') {
            emit(LoginFailure(errorMessage: 'user not found'));
          } else if (ex.code == 'wrong-password') {
            emit(LoginFailure(errorMessage: 'wrong password'));
          }
        } catch (e) {
          emit(LoginFailure(errorMessage: "something went wrong"));
        }
      } else if (event is AuthEventRegister) {
        emit(RegisterLoading());
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'email-already-in-use') {
            emit(RegisterFailure(errorMessage: 'email already in use'));
          } else if (ex.code == 'invalid-email') {
            emit(RegisterFailure(errorMessage: 'invalid email'));
          }
        } catch (e) {
          emit(RegisterFailure(errorMessage: "something went wrong"));
        }
      }
    });
  }
}
