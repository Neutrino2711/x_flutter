import 'dart:async';

import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:x/data/models/user.dart';
import 'package:x/constants/constants.dart';


part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.authToken,required this.dio}) : super(InitialUserState()) {
   on<GetInitialUserData>(_onGetInitialUserData);
   on<UserUpdate>(_onUserUpdate);


  }
  final String authToken;
  final Dio dio;

  Future<void> _onGetInitialUserData(GetInitialUserData event,Emitter<UserState> emit) async{
    // emit(LoadingUserState());
    try{
      final response = await dio.get(
        UserApiConstants.me,
        options :Options(
          headers: {
            'Authorization': 'Token $authToken',
          }
        )
      );
      final user = User.fromMap(response.data);
      emit(LoadedUserState(user:user));

    } on DioException catch(e){
      emit(ErrorUserState( e.response?.data['message']));
    }
  }

  Future<FutureOr<void>> _onUserUpdate(UserUpdate event,Emitter<UserState> emit) async {
    emit(LoadedUserState(user: state.user));
    Map<String,dynamic> data = Map<String,dynamic>.from(event.jsonMap);
    if (event.jsonMap.containsKey('profile_pic')) {
      data['profile_pic'] = event.jsonMap['profile_pic']!=null? await MultipartFile.fromFile(
        event.jsonMap['profile_pic'].path,
      ):null;
  }
  try{
    final response =await dio.patch(
      UserApiConstants.me,
      options : Options(
        headers: {
          'Authorization': 'Token $authToken',
        }
        
        ),
        data: FormData.fromMap(data),
    );
  User newUser = User.fromMap(response.data);
  emit(LoadedUserState(user:newUser));

  }on DioException catch(e){
    emit(state.copyWith(status: UserStatus.error,error: e.response?.data['message']));
  }

  }
}
