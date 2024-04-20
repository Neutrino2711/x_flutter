import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:x/data/repos/auth_repo.dart';


part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit({required this.authRepository}) : super(UnAuthLogin());

  void login(String email,String password) async {
    emit(const AuthLoadingLogin());
    try {
      final token = await authRepository.login(email, password);
      emit(AuthLoggedIn(token));
    } on Exception catch(e){
      String error = e.toString();
      error = error.replaceAll('Exception:', '');
      emit(AuthFailedLogin(error));
    }
  }

  void logout()async {
    emit(const UnAuthLogin());
  }

  void register ({required String email,required String password,String? name,File? profilePic}) async {
    emit(const AuthLoadingResgister());
    try {
      await authRepository.register(email: email, password: password, name: name, profile_pic: profilePic);
      emit (const UnAuthLogin());

    } on Exception catch (e){
      String error = e.toString();
      error = error.replaceAll('Exception:', '');
      emit(AuthFailedRegister(error));
    }
  }

  void navigateToRegister() {
    emit(const UnAuthRegister());
  }

  void navigateToLogin(){
    emit (const UnAuthLogin());
  }

  @override 
  AuthState? fromJson(Map<String, dynamic> json) {
    if (json['authStatus'] == 'authenticated') {
      return AuthLoggedIn(json['token']);
    } else {
      return null;
    }
  }

  @override 
  Map<String,dynamic>? toJson(AuthState state){
    if (state is AuthLoggedIn){
      return {
        'authStatus': 'authenticated',
        'token': state.token,
      };
    }
    return {
      "authStatus": "unauthenticated",
    };
  }

}
