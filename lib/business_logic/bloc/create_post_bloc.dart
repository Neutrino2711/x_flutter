import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:x/constants/constants.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc({required this.authToken,required this.dio}) : super(CreatePostInitial()) {
    on<CreatePostOnlyEvent>(_onCreatePostEvent);
    on<CreateCommentEvent>(_onCreateCommentEvent);
  }

  final Dio dio;
  final String authToken;


Future<void> _onCreatePostEvent(CreatePostOnlyEvent event,Emitter<CreatePostState> emit)async {
  emit(CreatePostLoading());
  try{

        final formData = FormData.fromMap(
          {
            'content':event.content,
            'image':event.image != null? await MultipartFile.fromFile(event.image!):null 
          }
        );

  
        final response = await dio.post(
          PostConstants.postCreateUrl,
          data: formData,
          options: Options(
            headers: 
            {'Authorization': 'Token $authToken'},),
        );
        
        if(response.statusCode == 201)
        {
          emit(CreatePostLoaded());
        }
        else
        {
          emit(CreatePostError(error: response.statusMessage!));
        
        }
        
  }
  on DioException  catch (e) {
      if (e.response != null) {
        emit(CreatePostError(error: e.response!.data['message']));
      } else {
        emit(const CreatePostError(
            error: 'Something went wrong. Please try again later.'));
      }
  }
  catch(e)
  {
    print(e);
    emit(CreatePostError(error: e.toString()));
  }
}

Future<void> _onCreateCommentEvent( CreateCommentEvent event,Emitter<CreatePostState> emit) async{
  emit(CreatePostLoading());
  try{

        final formData = FormData.fromMap(
          {
            'content':event.content,
            'image':event.image != null? await MultipartFile.fromFile(event.image!):null, 
            'parent': event.postId
          }
        );

  
        final response = await dio.post(
          PostConstants.postCreateUrl,
          data: formData,
          options: Options(
            headers: 
            {'Authorization': 'Token $authToken'},),
        );
        
        if(response.statusCode == 201)
        {
          emit(CreatePostLoaded());
        }
        else
        {
          emit(CreatePostError(error: response.statusMessage!));
        
        }
        
  }
  on DioException  catch (e) {
      if (e.response != null) {
        emit(CreatePostError(error: e.response!.data['message']));
      } else {
        emit(const CreatePostError(
            error: 'Something went wrong. Please try again later.'));
      }
  }
  catch(e)
  {
    print(e);
    emit(CreatePostError(error: e.toString()));
  }
}

  @override
  void onTransition(Transition<CreatePostEvent, CreatePostState> transition) {
    print(transition);
    super.onTransition(transition);
}

}