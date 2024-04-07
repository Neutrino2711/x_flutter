part of 'post_list_bloc.dart';

@immutable
sealed class PostListState extends Equatable{
  const PostListState();

  @override
  List<Object> get props => [];

}

final class PostListInitial extends PostListState {


}

final class PostListLoading extends PostListState {}

final class PostListLoaded extends PostListState {
  final List<Postslist> postsList;

  PostListLoaded(this.postsList);

  @override
  List<Object> get props => [postsList];
}

final class PostListError extends PostListState {
  final String message;

  PostListError(this.message);

  @override
  List<Object> get props => [message];
}
