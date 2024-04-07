part of 'auth_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

@immutable
sealed class AuthState extends Equatable {
  final AuthStatus authStatus;
  final String? token;
  final String? error;

  const AuthState({
    this.authStatus = AuthStatus.unknown,
    this.token,
    this.error,
  });

  String? get authToken => token;

  @override
  List<Object> get props => [authStatus, token!, error!];

 

}

 //states related to register
  abstract class AuthRegisterState extends AuthState {
    const AuthRegisterState({String? error}):super(authStatus: AuthStatus.unauthenticated, error: error);
  }

