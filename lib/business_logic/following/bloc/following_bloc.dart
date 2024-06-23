import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:x/constants/constants.dart';

part 'following_event.dart';
part 'following_state.dart';

class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {
  FollowingBloc({required this.authToken,required this.dio}) : super(FollowingInitial()) {
    on<AddFollowingEvent>(_onGetAddFollowingEvent);
  }

  final String authToken;
  final Dio dio;

  Future<void> _onGetAddFollowingEvent(AddFollowingEvent event , Emitter<FollowingState> emit)async {
    emit(FollowingLoading());
    try {
      final formData = FormData.fromMap(
        {
          'user_pk': event.pk,
        }
      );

      final response = await dio.post(
        UserApiConstants.following,

        data: formData,
        options: Options(
          headers: {'Authorization': 'Token $authToken'},),
      );
      if(response.data['status'] == 'following')
      {
        emit(FollowingLoaded(status: true));
      }
      else
      {
        emit(FollowingLoaded(status: false));
      }
    }
    on DioException catch (e) {
      if (e.response != null) {
        emit(FollowingError(message: e.response!.data['message']));
      } else {
        emit(const FollowingError(
            message: 'Something went wrong. Please try again later.'));
      }
    }
    catch(e)
    {
      print(e);
      emit(FollowingError(message: e.toString()));
    }
  }
}
