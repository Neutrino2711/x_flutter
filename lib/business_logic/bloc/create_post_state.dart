part of 'create_post_bloc.dart';

sealed class CreatePostState extends Equatable {
  const CreatePostState();
  
  @override
  List<Object> get props => [];
}

final class CreatePostInitial extends CreatePostState {}

final class CreatePostLoading extends CreatePostState{}

final class CreatePostLoaded extends CreatePostState{}

final class CreatePostError extends CreatePostState{
  final String error;

  const CreatePostError({required this.error});
}
