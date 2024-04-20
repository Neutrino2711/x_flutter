part of 'auth_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

@immutable
sealed class AuthState extends Equatable {
  final AuthStatus authStatus;
  final String? token;
  final String? error;

  const AuthState({
    required this.authStatus,
    this.token,
    this.error,
  });

  String? get authToken => token;

  @override
  List<Object?> get props => [authStatus, token, error];

 

}

//need for abstract class is to provide a blueprint to other specific state classes

 //all states related to register
  abstract class AuthRegisterState extends AuthState {
    const AuthRegisterState({String? error}):super(authStatus: AuthStatus.unauthenticated, error: error);
  }

  //all states related to login 
  abstract class AuthLoginState extends AuthState {
    const AuthLoginState({String? error}):super(authStatus: AuthStatus.unauthenticated, error: error);
  }


  //all specific state classes from here
  final class AuthLoggedIn extends AuthState {
    const AuthLoggedIn(String token):super(authStatus: AuthStatus.authenticated, token: token);
  }

  //first use of abstract class
  //Unauthenticated and on login screen
  final class UnAuthLogin extends AuthLoginState{
    const UnAuthLogin():super();
  } 

  final class UnAuthRegister extends AuthRegisterState{
    const UnAuthRegister():super();
  }

  //loading state for login
  //why is there an error in the below class?
  final class AuthLoadingLogin extends AuthLoginState {
    const AuthLoadingLogin():super();
  }

  //loading state for register
  final class AuthLoadingResgister extends AuthRegisterState {
    const AuthLoadingResgister():super();
  }

  //error state for login
  final class AuthFailedLogin extends AuthLoginState {
    const AuthFailedLogin(String error):super(error: error);
  }

  //failed state for register
  final class AuthFailedRegister extends AuthRegisterState {
    const AuthFailedRegister(String error):super(error: error);
  }

  

  

