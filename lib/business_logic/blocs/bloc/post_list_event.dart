part of 'post_list_bloc.dart';

@immutable
sealed class PostListEvent extends Equatable{
  const PostListEvent();

  @override
  List<Object> get props => [];
}

final class GetPostListEvent extends PostListEvent{}