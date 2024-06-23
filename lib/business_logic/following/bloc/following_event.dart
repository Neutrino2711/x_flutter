part of 'following_bloc.dart';

sealed class FollowingEvent extends Equatable {
  const FollowingEvent();

  @override
  List<Object> get props => [];
}

final class AddFollowingEvent extends FollowingEvent {
  final int pk;
  const AddFollowingEvent(this.pk);
}