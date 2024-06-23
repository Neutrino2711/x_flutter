part of 'following_bloc.dart';

sealed class FollowingState extends Equatable {
  const FollowingState();
  
  @override
  List<Object> get props => [];
}

final class FollowingInitial extends FollowingState {}

final class FollowingLoading extends FollowingState {}

final class FollowingLoaded extends FollowingState{
final bool status;
  const FollowingLoaded({required this.status});
}

final class FollowingError extends FollowingState {
  final String message;
  const FollowingError({required this.message});
}
