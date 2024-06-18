part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  const CommentState();
  
  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

final class CommentLoading extends CommentState {}

final class CommentLoaded extends CommentState{
  final List<Postslist> comments;
  CommentLoaded(this.comments);
  @override
  List<Object> get props => [comments];
}

final class CommentError extends CommentState{
  final String message;
  CommentError(this.message);
  @override
  List<Object> get props => [message];
}
