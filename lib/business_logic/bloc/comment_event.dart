part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

final class GetCommentListEvent extends CommentEvent{
  final int postId;
  GetCommentListEvent(this.postId);
}