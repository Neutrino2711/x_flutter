part of 'single_community_post_bloc.dart';

sealed class SingleCommunityPostState extends Equatable {
  const SingleCommunityPostState();
  
  @override
  List<Object> get props => [];
}

final class SingleCommunityPostInitial extends SingleCommunityPostState {}

final class SingleCommunityPostLoading extends SingleCommunityPostState {}

final class SingleCommunityPostLoaded extends SingleCommunityPostState{
  final SinglePost post;
  SingleCommunityPostLoaded(this.post);
  @override
  List<Object> get props => [post];
}

final class SingleCommunityPostError extends SingleCommunityPostState{
  final String message;
  SingleCommunityPostError(this.message);
  @override
  List<Object> get props => [message];
}