part of 'userlist_bloc.dart';

sealed class UserlistState extends Equatable {
  const UserlistState();
  
  @override
  List<Object> get props => [];
}

final class UserlistInitial extends UserlistState {}

final class UserlistLoading extends UserlistState{}

final class UserlistLoaded extends UserlistState {
  final List<User> users;

  const UserlistLoaded(this.users);

  @override
  List<Object> get props => [users];
}

final class UserlistError extends UserlistState {
  final String message;

  const UserlistError(this.message);

  @override
  List<Object> get props => [message];
}
