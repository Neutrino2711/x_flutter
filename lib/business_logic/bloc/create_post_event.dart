part of 'create_post_bloc.dart';

class CreatePostEvent extends Equatable {
  final String? content;
  final String? image;

  
  const CreatePostEvent({this.content,this.image});

  @override
  List<Object> get props => [content!,image!];
}


