import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:x/constants/constants.dart';
import 'package:x/data/models/posts_list.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc({required this.authToken,required this.dio}) : super(CommentInitial()) {
    on<GetCommentListEvent>(_onGetCommentListEvent
    );
  }
  Dio dio;
  String authToken;


Future<void> _onGetCommentListEvent(GetCommentListEvent event, Emitter<CommentState> emit) async {
  emit(
    CommentLoading());
  try{
    print(event.postId);
    print(PostConstants.commentUrl(event.postId));
    final response = await dio.get(
        PostConstants.commentUrl(event.postId),
      options: Options(
        headers: 
        {'Authorization': 'Token $authToken'},),
    );
    // print(response);
    List<Postslist> postsList = (response.data as List).map((e) => Postslist.fromMap(e)).toList();
    print(postsList.last);
    emit(CommentLoaded(postsList));
  }
  catch(e)
  {
    print(e);
    emit(CommentError(e.toString()));
  }
}
}