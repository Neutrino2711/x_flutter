import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:x/constants/constants.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc({required this.authToken,required this.dio}) : super(CreatePostInitial()) {
    on<CreatePostEvent>(_onCreatePostEvent);
  }

  final Dio dio;
  final String authToken;


Future<void> _onCreatePostEvent(CreatePostEvent event,Emitter<CreatePostState> emit)async {
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

}