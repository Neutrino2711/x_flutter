import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:x/data/models/single_post.dart';
import 'package:x/constants/constants.dart';

part 'single_community_post_event.dart';
part 'single_community_post_state.dart';

class SingleCommunityPostBloc extends Bloc<SingleCommunityPostEvent, SingleCommunityPostState> {
  SingleCommunityPostBloc({
    required this.postId,
    required this.dio,
    required this.authToken,
  }) : super(SingleCommunityPostInitial()) {
    on<GetSingleCommunityPostEvent> (_onGetSingleCommunityPost);
    on<BookMarkSingleCommunityPostEvent>(_onBookMarkSingleCommunityPost);
    on<AddLikeDislikeSingleCommunityPostEvent>(_onAddLikeDislikeSingleCommunityPost);
    on<RemoveLikeDislikeSingleCommunityPostEvent>(_onRemoveLikeDislikeSingleCommunityPost);
    on<ChangeLikeDislikeSingleCommunityPostEvent>(_onChangeLikeDislikeSingleCommunityPost);
  }
  int postId;
  Dio dio;
  String authToken;

  void _onGetSingleCommunityPost(GetSingleCommunityPostEvent event,Emitter<SingleCommunityPostState>emit) async{
    emit(SingleCommunityPostLoading());
    try{
      print(postId);
      print(PostConstants.postDetail(postId));
      Response response = await dio.get(
        PostConstants.postDetail(postId),

        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          }
        ),
      );
      SinglePost post = SinglePost.fromMap(response.data);
      emit(SingleCommunityPostLoaded(post));
    }catch(e){
      emit(SingleCommunityPostError(e.toString()));
    }
  }

  void _onBookMarkSingleCommunityPost(BookMarkSingleCommunityPostEvent event,Emitter<SingleCommunityPostState>emit) async{
    SinglePost singlePost = (state as SingleCommunityPostLoaded).post;
    emit(SingleCommunityPostLoaded(singlePost.copyWith(is_bookmarked: !singlePost.is_bookmarked)));
    try{
      dio.post(
        PostConstants.bookmarkUrl(postId),
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          }
        ),
      );
      
      
    }catch(e){
      emit(SingleCommunityPostLoaded(singlePost));
    }
  }

  void _onAddLikeDislikeSingleCommunityPost(AddLikeDislikeSingleCommunityPostEvent event,Emitter<SingleCommunityPostState>emit) async{
    SinglePost singlePost = (state as SingleCommunityPostLoaded).post;
    emit(SingleCommunityPostLoaded(singlePost.copyWith(
    score: singlePost.score! + event.vote,
    vote: event.vote
    )));
    try{
      dio.post(
        PostConstants.voteUrl(postId),
        data: {
          'vote': event.vote,
        },
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          }
        ),
      );
      
      
    }catch(e){
      emit(SingleCommunityPostLoaded(singlePost));
    }
  }

  void _onRemoveLikeDislikeSingleCommunityPost(RemoveLikeDislikeSingleCommunityPostEvent event,Emitter<SingleCommunityPostState> emit)
   async
   {
    SinglePost singlePost = (state as SingleCommunityPostLoaded).post;

    emit(SingleCommunityPostLoaded(
      singlePost.copyWith(
        score: singlePost.score! - event.vote,
        vote: -1,
        ),
        ),
        );
    try{
      dio.post(
        PostConstants.voteUrl(postId),
        data: {"vote": event.vote},
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          }
        )
        );
      
    }
    catch(e)
    {
      emit(SingleCommunityPostLoaded(singlePost));
    }
  }

  void _onChangeLikeDislikeSingleCommunityPost(
    ChangeLikeDislikeSingleCommunityPostEvent event,
    Emitter<SingleCommunityPostState> emit) async {
      SinglePost post = (state as SingleCommunityPostLoaded).post;
      emit(SingleCommunityPostLoaded(
       post.copyWith(
        score: post.score! + 2*event.vote,
        vote: event.vote,
       ) 
      ));
      try{
        dio.post(
          PostConstants.voteUrl(postId),
          data: {'vote': event.vote},
          options: Options(headers: {
            'Authorization': 'Token $authToken',
          }),
        );
      }
      catch(e)
      {
        emit(SingleCommunityPostLoaded(post));
      }
    }

  

}
