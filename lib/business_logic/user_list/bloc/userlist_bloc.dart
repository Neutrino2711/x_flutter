import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:x/business_logic/blocs/bloc/post_list_bloc.dart';
import 'package:x/constants/constants.dart';
import 'package:x/data/models/user.dart';

part 'userlist_event.dart';
part 'userlist_state.dart';

class UserlistBloc extends Bloc<UserlistEvent, UserlistState> {
  UserlistBloc({required this.authToken,required this.dio}) : super(UserlistInitial()) {
    on<GetUserList>(_onGetUserList);
    on<SearchUserList>(_onSearchUserList);
    on<FollowingUserList>(_onGetFollowingList);
  }

  final String authToken;
  final Dio dio;

  Future<void> _onGetUserList(GetUserList event, Emitter<UserlistState> emit) async {
    emit(UserlistLoading());
    try {
      
      final response = await dio.get(
        UserApiConstants.baseurl,
        options: Options(
          headers: {'Authorization': 'Token $authToken'}),
      
      );
      List<User> users = (response.data as List).map((e) => User.fromMap(e)).toList();

      emit(UserlistLoaded(users));
      
    } catch (e) {
      emit(UserlistError(e.toString()));
    }
  }
    Future<void> _onSearchUserList(SearchUserList event, Emitter<UserlistState> emit) async {
    emit(UserlistLoading());
    try{
      final response = await dio.get(
        UserApiConstants.baseurl,
        options: Options(

          headers: {'Authorization': 'Token $authToken'}),
        queryParameters: {'search': event.search},
      );
      List<User> users = (response.data as List).map((e) => User.fromMap(e)).toList();

      emit(UserlistLoaded(users));
    }
    catch(e){
      emit(UserlistError(e.toString()));
    }
  }

  Future<void> _onGetFollowingList(FollowingUserList event,Emitter<UserlistState> emit)
  async {
    emit(UserlistLoading());
    try{
      final response = await dio.get(
        UserApiConstants.following,
        options: Options(
          headers: {'Authorization': 'Token $authToken'}),
      );

      List<User> users = (response.data as List).map((e) => User.fromMap(e)).toList();
      emit(UserlistLoaded(users));
    }
      catch(e)
      {
        emit(UserlistError(e.toString()));
      }

}
}