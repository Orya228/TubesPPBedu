import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:meta/meta.dart';

import '../../repositories/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final _repo = AuthRepo();

  void login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential =
          await _repo.login(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        emit(LoginSuccess('Login berhasil!', user));
      } else {
        emit(LoginFailure('User tidak ditemukan.'));
      }
    } catch (e) {
      print(e);
      emit(LoginFailure(e.toString()));
    }
  }
}
