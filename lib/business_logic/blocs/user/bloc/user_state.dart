part of 'user_bloc.dart';

enum UserStatus {intial,loading,loaded,error}

 class UserState extends Equatable {
  final User? user;
  final UserStatus status;
  final String? error;

  
  const UserState({
    this.user,
    this.status = UserStatus.intial,
    this.error,
  });
  
  @override
  List<Object> get props => [status];

  UserState copyWith({
    User? user,
    UserStatus? status,
    String? error,
  }){
    return UserState(
      user: user??this.user,
      status: status??this.status,
      error: error??this.error,
    );
  }

}

//Initial state of UserBloc has no user data and also shows intial screen

final class InitialUserState extends UserState {
  const InitialUserState():super(status: UserStatus.intial);
}

//Error state of UserBloc to show error before initalizing the user
final class ErrorUserState extends UserState{
  const ErrorUserState(String error):super(status: UserStatus.error,error: error);
}

//InitailizedUserState is abstract class to show user data after initialized.Subclasses of this class will have the user data
abstract class InitializedUserState extends UserState{
  const InitializedUserState({User? user,String? error,UserStatus? status}):super(status: UserStatus.loaded,user: user);
}

//The default UserState when user loads first time
final class LoadedUserState extends InitializedUserState{
  const LoadedUserState({required User? user}): super (user:user);


}

//Error state for errors after initializing the user such as error in updating user data
final class InitializedUserErrorState extends InitializedUserState{
  const InitializedUserErrorState({required User? user,required String? error}):super(user:user,error:error,status:UserStatus.error);
}

//Loading state to show loading after initializing the user, such as loading while updating the user data
final class InitializedUserLoadingState extends InitializedUserState{
  const InitializedUserLoadingState({required User? user}):super(user:user,status: UserStatus.loading);
}