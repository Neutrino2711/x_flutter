import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:x/constants/constants.dart';
import 'package:x/data/models/posts_list.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
part 'post_list_event.dart';
part 'post_list_state.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  PostListBloc({required this.authToken,required this.dio,this.savedPosts = false,this.myPosts = true}) : super(PostListInitial()) {
   
   
    on<GetPostListEvent>(_onGetPostListEvent);
    add(GetPostListEvent());
  }

  Dio dio;
  String authToken;
  final bool savedPosts ;
  final bool myPosts ;
  


  Future<void> _onGetPostListEvent(GetPostListEvent event, Emitter<PostListState> emit) async {
    emit(
      PostListLoading());
    try{
      final response = await dio.get(
         savedPosts? PostConstants.bookmarklistUrl:PostConstants.postCreateUrl,
        options: Options(
          headers: 
          {'Authorization': 'Token $authToken'},),
      );
      // print(response);
      List<Postslist> postsList = (response.data as List).map((e) => Postslist.fromMap(e)).toList();
      print(postsList.last);
      emit(PostListLoaded(postsList));


    }
    catch(e)
    {
      print(e);
      emit(PostListError(e.toString()));
    }

  }




}

