part of 'userlist_bloc.dart';

sealed class UserlistEvent extends Equatable {
  const UserlistEvent();

  @override
  List<Object> get props => [];
}

final class GetUserList extends UserlistEvent {
  
  
}

final class FollowingUserList extends UserlistEvent {
 
}

final class SearchUserList extends UserlistEvent {
    final String search;

  const SearchUserList(this.search);
}
