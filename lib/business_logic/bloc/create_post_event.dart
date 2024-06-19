part of 'create_post_bloc.dart';

class CreatePostEvent extends Equatable {


  
  const CreatePostEvent();

  @override
  List<Object> get props => [];

}

class CreatePostOnlyEvent extends CreatePostEvent {
  final String? content;
  final String? image;

  const CreatePostOnlyEvent({this.content, this.image});

  @override
  List<Object> get props => [content!, image!];
}

class CreateCommentEvent extends CreatePostEvent {
  final String? content;
  final String? image;
  final int? postId;

  const CreateCommentEvent({this.content, this.image, this.postId});

  // @override
  // List<Object> get props => [content!, image!];
}


