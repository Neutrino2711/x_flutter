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
    on<GetFollowingPostListEvent>(_onGetFollowingPostListEvent);
    on<GetUserPostsEvent>(_onGetUserPostsEvent);
    on<GetSavedPostsEvent>(_onGetSavedPostsEvent);
    // add(GetPostListEvent());
  }

  Dio dio;
  String authToken;
  final bool savedPosts ;
  final bool myPosts ;
  // final bool followingPosts;
  


  Future<void> _onGetPostListEvent(GetPostListEvent event, Emitter<PostListState> emit) async {
    emit(
      PostListLoading());
    try{
      final response = await dio.get(
         savedPosts? PostConstants.bookmarklistUrl: PostConstants.postCreateUrl,
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
  Future<void> _onGetFollowingPostListEvent(GetFollowingPostListEvent event, Emitter<PostListState> emit) async {
    emit(
      PostListLoading());
    try{
      final response = await dio.get(
          PostConstants.followingPostlistUrl,
        options: Options(
          headers: 
          {'Authorization': 'Token $authToken'},),
      );
      // print(response);
      List<Postslist> postsList = (response.data as List).map((e) => Postslist.fromMap(e)).toList();
      // print(postsList.last);
      emit(PostListLoaded(postsList));


    }
    catch(e)
    {
      print(e);
      emit(PostListError(e.toString()));
    }

  }

  Future<void> _onGetUserPostsEvent(GetUserPostsEvent event,Emitter<PostListState> emit)async
  {
    emit(
      PostListLoading());
    try{
      final response = await dio.get(
          PostConstants.postlistUrl,
        options: Options(
          headers: 
          {'Authorization': 'Token $authToken'},),
      );
      // print(response);
      List<Postslist> postsList1 = (response.data as List).map((e) => Postslist.fromMap(e)).toList();
      // print(postsList1.last);
      emit(PostListLoaded(postsList1));


    }
    catch(e)
    {
      print(e);
      emit(PostListError(e.toString()));
    }
  }

  Future<void> _onGetSavedPostsEvent(GetSavedPostsEvent event,Emitter<PostListState> emit)async
  {
    emit(
      PostListLoading());
    try{
      final response = await dio.get(
          PostConstants.bookmarklistUrl,
        options: Options(
          headers: 
          {'Authorization': 'Token $authToken'},),
      );
      // print(response);
      print("her");
      List<Postslist> bookmarkList = (response.data as List).map((e) => Postslist.fromMap(e)).toList();
      // print(bookmarkList);
      emit(PostListLoaded(bookmarkList));


    }
    catch(e)
    {
      print(e);
      emit(PostListError(e.toString()));
    }
  }


}

